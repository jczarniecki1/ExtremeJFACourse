mongoose = require 'mongoose'
Rating   = mongoose.model 'Rating'

courseSchema = mongoose.Schema
  title:
    type:     String
    required: '{PATH} is required'

  description:
    type:     String

  featured:
    type:     Boolean
    default:  false

  created:
    type:     Date
    default:  new Date()

  lastUpdate:
    type:     Date
    default:  new Date()

  published:
    type:     Boolean
    default:  false

  readyToTest:
    type:     Boolean
    default:  false

  publishDate:
    type:     Date

  tags:
    type:     [String]

  avgRating:
    type:     Number
    min:      0
    default:  0

  challengesCount:
    type:     Number
    min:      0
    default:  0

courseSchema.methods =
  updateRating: ->
    Rating.find({objectId:@_id}).exec (err, collection) =>
      unless err?
        @avgRating = collection.avg (x) -> x.value
        @save()


Course = mongoose.model 'Course', courseSchema

exports.createDefaultCourses = ->
  Course.find({}).exec (err, collection) ->
    if collection.length is 0
      Course.create {title: 'C# for Humanists', featured: true, publishDate: new Date('4/1/2014'), published: true, tags: ['C#']}
      Course.create {title: 'C# for Pacifists', publishDate: new Date('5/11/2014'), published: true, tags: ['C#','Coding']}
      Course.create {title: 'Java 8 - Introducing Lambda Expressions', featured: true, publishDate: new Date('5/12/2014'), published: true, tags: ['Java']}
      Course.create {title: 'Writing 80% less code with Angular.js', publishDate: new Date('5/14/2014'), published: true, tags: ['JavaScript','Coding']}
      Course.create {title: 'C# for Pacifists - part 2', publishDate: new Date('6/30/2014'), readyToTest: true, tags: ['JavaScript','Coding']}
      Course.create {title: 'C# for Humanists - part 2', featured: true, publishDate: new Date('6/26/2014'), tags: ['C#']}
