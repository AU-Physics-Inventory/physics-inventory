use physics_inventory

db.createCollection("assets", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["location", "name", "missing", "manuals", "mfrInfo", "purchases", "maintenance"],
            properties: {
                name: {
                    bsonType: "string",
                    description: "name of the asset; required"
                },
                location: {
                    bsonType: "string",
                    description: "location code of the asset; required"
                },
                keywords: {
                    bsonType: "array",
                    description: "keywords that describe the asset",
                    items: {
                        bsonType: "string"
                    }
                },
                mfrInfo: {
                    bsonType: "object",
                    description: "details that come straight from the manufacturer; required",
                    properties: {
                        brand: {
                            bsonType: "string",
                            description: "asset brand name"
                        },
                        model: {
                            bsonType: "string",
                            description: "asset model name"
                        },
                        partNo: {
                            bsonType: "string",
                            description: "part number"
                        },
                        serialNo: {
                            bsonType: "string",
                            description: "serial number"
                        }
                    }
                },
                AUInventoryNo: {
                    bsonType: "string",
                    description: "internal AU Inventory number"
                },
                purchases: {
                    bsonType: "array",
                    description: "details regarding each time this asset was purchased",
                    items: {
                        bsonType: "object",
                        description: "details regarding the purchase of this asset",
                        required: ["vendor"],
                        properties: {
                            vendor: {
                                bsonType: "object",
                                description: "vendor details",
                                required: ["name"],
                                properties: {
                                    name: {
                                        bsonType: "string",
                                        description: "vendor name"
                                    },
                                    url: {
                                        bsonType: "string",
                                        description: "vendor url"
                                    }
                                }
                            },
                            date: {
                                bsonType: "date",
                                description: "purchase date"
                            },
                            cost: {
                                bsonType: "double",
                                description: "purchase amount"
                            },
                            unitPrice: {
                                bsonType: "double",
                                description: "unit price of the asset"
                            },
                            quantity: {
                                bsonType: "object",
                                description: "details on the quantity purchased",
                                required: ["amount", "unit"],
                                properties: {
                                    amount: {
                                        bsonType: "double",
                                        description: "amount purchased; required"
                                    },
                                    unit: {
                                        bsonType: "string",
                                        description: "units of the amount purchased; required"
                                    }
                                }
                            },
                            url: {
                                bsonType: "string",
                                description: "purchase url"
                            },
                            receipt: {
                                bsonType: "string",
                                description: "receipt url"
                            }
                        }
                    }
                },
                totalQuantity: {
                    bsonType: "object",
                    description: "details on the total quantity purchased",
                    required: ["amount", "unit"],
                    properties: {
                        amount: {
                            bsonType: "double",
                            description: "total amount purchased; required"
                        },
                        unit: {
                            bsonType: "string",
                            description: "units of the total amount purchased; required"
                        }
                    }
                },
                missingReports: {
                    bsonType: "object",
                    description: "missing asset reports",
                    properties: {
                        reports: {
                            bsonType: "array",
                            description: "array of missing asset reports",
                            items: {
                                bsonType: "object",
                                description: "a missing asset report",
                                required: ["quantity", "date", "reportedBy"],
                                properties: {
                                    quantity: {
                                        bsonType: "object",
                                        description: "details on the quantity missing; required",
                                        required: ["amount", "unit"],
                                        properties: {
                                            amount: {
                                                bsonType: "double",
                                                description: "amount missing; required"
                                            },
                                            unit: {
                                                bsonType: "string",
                                                description: "units of the amount missing; required"
                                            }
                                        }
                                    },
                                    date: {
                                        bsonType: "date",
                                        description: "date reported missing; required"
                                    },
                                    reportedBy: {
                                        bsonType: "string",
                                        description: "name of person who made the report; required"
                                    },
                                }
                            },
                            recoveryReports: {
                                bsonType: "array",
                                description: "details on the recovery of the missing quantities",
                                items: {
                                    bsonType: "object",
                                    description: "recovery report",
                                    properties: {
                                        quantity: {
                                            bsonType: "object",
                                            description: "details on the quantity recovered; required",
                                            required: ["amount", "unit"],
                                            properties: {
                                                amount: {
                                                    bsonType: "double",
                                                    description: "amount recovered; required"
                                                },
                                                unit: {
                                                    bsonType: "string",
                                                    description: "units of the amount recovered; required"
                                                }
                                            }
                                        },
                                        date: {
                                            bsonType: "date",
                                            description: "date reported missing; required"
                                        },
                                        reportedBy: {
                                            bsonType: "string",
                                            description: "name of person who made the report; required"
                                        }
                                    }
                                }
                            },
                            quantity: {
                                bsonType: "object",
                                description: "details on the total quantity missing; required",
                                required: ["amount", "unit"],
                                properties: {
                                    amount: {
                                        bsonType: "double",
                                        description: "total amount missing; required"
                                    },
                                    unit: {
                                        bsonType: "string",
                                        description: "units of the total amount missing; required"
                                    }
                                }
                            }
                        }
                    }
                },
                identityNo: {
                    bsonType: "int",
                    description: "number that ties common assets together; formerly record_locator"
                },
                notes: {
                    bsonType: "string",
                    description: "notes entered by a user"
                },
                maintenance: {
                    bsonType: "object",
                    description: "describes the maintenance status of an asset; required",
                    required: ["status", "calibration"],
                    properties: {
                        status: {
                            bsonType: "object",
                            description: "status details",
                            required: ["current", "effectiveDate"],
                            properties: {
                                current: {
                                    enum: ["W", "C", "R", "T", "U"],
                                    description: "current status code"
                                },
                                effectiveDate: {
                                    bsonType: "date",
                                    description: "date of current status"
                                },
                                history: {
                                    bsonType: "array",
                                    description: "historical status changes",
                                    items: {
                                        bsonType: "object",
                                        description: "historical status",
                                        required: ["status", "date"],
                                        properties: {
                                            status: {
                                                enum: ["W", "C", "R", "T", "U"],
                                                description: "status code"
                                            },
                                            effectiveDate: {
                                                bsonType: "date",
                                                description: "date of status"
                                            },
                                        }
                                    }
                                }
                            }
                        },
                        calibration: {
                            bsonType: "object",
                            description: "calibration details",
                            properties: {
                                next: {
                                    bsonType: "date",
                                    description: "next calibration date"
                                },
                                last: {
                                    bsonType: "date",
                                    description: "last calibration date"
                                },
                                interval: {
                                    bsonType: "string",
                                    description: "interval between calibrations, in days"
                                },
                                history: {
                                    bsonType: "array",
                                    description: "historical calibration dates",
                                    items: {
                                        bsonType: "date",
                                        description: "date of calibration"
                                    }
                                }
                            }
                        },
                        notes: {
                            bsonType: "string",
                            description: "notes added by users"
                        }
                    }
                },
                isConsumable: {
                    bsonType: "boolean",
                    description: "specifies whether the asset is consumable"
                }
            }
        }
    }
})

db.createCollection("manuals", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            description: "details regarding user manuals/guides available for assets with a certain identityNo",
            required: ["identityNo", "hardcopy"],
            properties: {
                identityNo: {
                    bsonType: "int",
                    description: "number that ties common assets together; formerly record_locator; required"
                },
                hardcopy: {
                    bsonType: "boolean",
                    description: "specifies whether a hardcopy asset is available; required"
                },
                softcopy: {
                    bsonType: "string",
                    description: "url of the softcopy manual if available"
                }
            },
            additionalProperties: false
        }
    }
})

db.createCollection("labs", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            description: "lab course",
            required: ["name", "number", "labs"],
            properties: {
                name: {
                    bsonType: "string",
                    description: "course name; required"
                },
                number: {
                    bsonType: "string",
                    description: "AU Course Number; required"
                },
                location: {
                    bsonType: "string",
                    description: "room where lab takes place"
                },
                labs: {
                    bsonType: "array",
                    description: "array of labs that pertain to this particular course",
                    items: {
                        bsonType: "object",
                        description: "a lab that pertains to this course",
                        required: ["name", "resources"],
                        properties: {
                            name: {
                                bsonType: "string",
                                description: "lab name"
                            },
                            resources: {
                                bsonType: "array",
                                description: "array of resources used in this lab",
                                items: {
                                    bsonType: "object",
                                    description: "a resource used in this lab",
                                    required: ["type", "typeID", "quantities"],
                                    properties: {
                                        type: {
                                            enum: ["asset", "set", "group"],
                                            description: "resource type; required"
                                        },
                                        typeID: {
                                            bsonType: "int",
                                            description: "objectID of the resource"
                                        },
                                        quantities: {
                                            bsonType: "object",
                                            description: "quantities used in this lab",
                                            required: ["frontTable", "perStation"],
                                            properties: {
                                                frontTable: {
                                                    bsonType: "object",
                                                    description: "front table quantities",
                                                    required: ["amount", "unit"],
                                                    properties: {
                                                        amount: {
                                                            bsonType: "double",
                                                            description: "amount; required"
                                                        },
                                                        unit: {
                                                            bsonType: "string",
                                                            description: "units of the amount; required"
                                                        }
                                                    }
                                                },
                                                perStation: {
                                                    bsonType: "object",
                                                    description: "quantities per station",
                                                    required: ["amount", "unit"],
                                                    properties: {
                                                        amount: {
                                                            bsonType: "double",
                                                            description: "amount; required"
                                                        },
                                                        unit: {
                                                            bsonType: "string",
                                                            description: "units of the amount; required"
                                                        }
                                                    }
                                                }
                                            }
                                        },
                                        notes: {
                                            bsonType: "string",
                                            description: "setup and takedown notes entered by users"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
})

db.createCollection("sets", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            description: "sets composed of assets",

        }
    }
})

db.createCollection("irregularLocations", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            description: "locations that don't match the required format and need admin approval",
            required: ["user", "date", "assetID", "location"],
            properties: {
                user: {
                    bsonType: "string",
                    description: "name of person submitting this request"
                },
                date: {
                    bsonType: "date",
                    description: "date request was submitted",
                },
                assetID: {
                    bsonType: "int",
                    description: "objectID of the asset"
                },
                location: {
                    bsonType: "string",
                    description: "irregular location submitted by user"
                },
                comments: {
                    bsonType: "string",
                    description: "user submitted comments"
                },
                approval: {
                    bsonType: "object",
                    description: "approval details",
                    required: ["approved", "by", "date"],
                    properties: {
                        approved: {
                            bsonType: "boolean",
                            description: "specifies whether the location was approved or not"
                        },
                        by: {
                            bsonType: "string",
                            description: "name of person who approved/disapproved the location"
                        },
                        date: {
                            bsonType: "date",
                            description: "date location was approved/disapproved"
                        }
                    }
                }
            }
        }
    }
})

