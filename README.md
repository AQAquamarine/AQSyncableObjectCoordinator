AQSyncableObjectCoordinator
===========================

[iOS] Coordinates `AQSyncableObject`s for synchronization by Aquasync.

![](http://img.shields.io/cocoapods/v/AQMSecureRandom.svg?style=flat) [![Build Status](https://travis-ci.org/AQAquamarine/AQSyncableObjectCoordinator.svg)](https://travis-ci.org/AQAquamarine/AQSyncableObjectCoordinator) 

Helper Methods for Aquasync
---

```objc
# pragma mark - Methods that should be called when the objects updated
/** @name Methods that should be called when the objects updated */

/**
 *  Make the object dirty.
 *
 *  **This method should be called when syncable objects are created / updated.**
 *
 *  @param object An object that you want to mark as requiring synchronization.
 */
- (void)dirtifySyncableObject:(id<AQSyncableObject>)object;

# pragma mark - Methods that should be called when Marking as Pushed
/** @name Methods that should be called when Marking as Pushed */

/**
 *  Make the object undirty if the object not updated by the user from pushing delta.
 *
 *  **Typically, this method is called on `- markAsPushedUsingDeltaPack:` of `AQSyncableObjectAggregator`**
 *
 *  @param object An object that you want to mark as pushed
 *  @param delta  A delta that used to push changes.
 */
- (void)undirtifySyncableObjectIfNotUpdated:(id<AQSyncableObject>)object withDelta:(AQDelta *)delta;

# pragma mark - Working with Soft Deletion
/** @name Working with Soft Deletion */

/**
 *  Mark the object as deleted.
 *  To make the effect, you should query objects with additional predicate: `aq_isDirty == NO`
 *
 *  **This method should be called when you want to delete syncable objects. Do not do hard deletion.**
 *
 *  @param object An object you want to delete
 */
- (void)markAsDeleteObject:(id<AQSyncableObject>)object;

# pragma mark - Apply a Delta patch for merging DeltaPacks
/** @name Apply a Delta patch for merging DeltaPacks */

/**
 *  Returns the Delta patch applied syncable object if the delta's localTimestamp is newer than syncable object's.
 *  Otherwise, it returns original syncable object.
 *
 *  **This method should be called when merging a DeltaPack. Typically it is called on `- updateRecordsUsingDeltaPack:` of `AQSyncableObjectAggregator` protocol.**
 *
 *  @param syncableObject A syncable object you want to apply a patch with a delta. This object should conforms to both `AQSyncableObject` and `AQSDictionarySerialization`.
 *  @param delta          A delta you want to apply a patch with
 *
 *  @return The delta patch applied syncable object or the syncable object
 */
- (id)patchAppliedObjectIfUpdatedWithSyncableObject:(NSObject <AQSyncableObject, AQSDictionarySerialization>*)syncableObject withDelta:(AQDelta *)delta;
```

Predicates for Aquasync
---

```objc
@interface NSPredicate (AquaSync)

/**
 *  Typically used on `- markAsPushedUsingDeltaPack:`, `- updateRecordsUsingDeltaPack:` of `AQSyncableObjectAggregator` protocol.
 *
 *  @param aq_gid `aq_gid` of `AQSyncableObject`
 *
 *  @return A predicate for querying syncable object with `aq_gid`.
 */
+ (instancetype)aq_predicateWithGid:(NSString *)aq_gid;

/**
 *  Returns a predicate that considers Aquasync's soft deletion.
 *  All of predicates you use should be instantiated by this method.
 *
 *  @param format A predicate format
 *  @param ...    Comma-separated arguments that substitutes format variables
 *
 *  @return A predicate that consideres soft deletion with `aq_isDeleted`
 */
+ (instancetype)aq_predicateWithFormat:(NSString *)format, ...;

/**
 *  In `- deltaPackForSynchronization` of `AQSyncableObjectAggregator` protocol, it is recommended to use this predicate to find dirty objects.
 *
 *  @return A predicate for querying dirty syncable objects. (`aq_isDirty == YES`)
 */
+ (instancetype)aq_predicateForDirtySyncableObjects;

@end
```

Document
---

- [appledoc](https://dl.dropboxusercontent.com/u/7817937/___doc___AQSyncableObjectCoordinator/html/index.html)

Related Projects
---

- Aquasync iOS https://github.com/AQAquamarine/aquasync-ios
- Aquasync Protocol https://github.com/AQAquamarine/aquasync-protocol

LICENSE
---

```
The MIT License (MIT)

Copyright (c) 2014 Aquamarine

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
