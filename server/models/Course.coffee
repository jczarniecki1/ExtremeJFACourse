mongoose = require 'mongoose'
Rating   = mongoose.model 'Rating'

courseSchema = mongoose.Schema
  title:
    type:     String
    required: '{PATH} is required'

  featured:
    type:     Boolean
    required: '{PATH} is required'

  published:
    type:     Date
    required: '{PATH} is required'

  tags:
    type:     [String]

  avgRating:
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
      Course.create {title: 'C# for Humanists', featured: true, published: new Date('4/1/2014'), tags: ['C#']}
      Course.create {title: 'C# for Pacifists', featured: false, published: new Date('5/11/2014'), tags: ['C#','Coding']}
      Course.create {title: 'Java 8 - Introducing Lambda Expressions', featured: true, published: new Date('5/12/2014'), tags: ['Java']}
      Course.create {title: 'Writing 80% less code with Angular.js', featured: false, published: new Date('5/14/2014'), tags: ['JavaScript','Coding']}