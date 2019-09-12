# Description

This lib creates a deterministic data structure like a vaguely-matched set. 

# Configuration

## comparable_types: [Object, Array, Integer, etc]
## sameness_threshold: 10 (maximum distance in percentage)
## recursion_limit: 1 (maximum depth when comparing objects in objects; 0 for only top-level sameness checking)

# Methods

## #add(obj)
Adds `obj` to the set. 

### Optional params
* `identifiers: keys_array` - These keys must be identical for two objects to be the "same". If two objects have all of the same identifier values, they will always be counted as the same. 

For example, two otherwise-identical objects with different `id` values wouldn't be considered the same if `id` existed in `keys_array`. 

## #remove(obj)
Removes `obj` and any `obj`-like objects from the set.

## #find(obj)
If `obj` is the same as any objects in the set, returns the primary version of the `obj` equivalent in the set.

## #includes?(obj)
Returns whether `obj` is the same as any object in the set.

## #count
Groups the set's objects by sameness and returns the unique count

## #actual_count
Returns how many objects are actually in the set.

# Sameness and difference
