package com.cloverdx.examples;

import org.jetel.data.DataRecord;
import org.jetel.exception.ComponentNotReadyException;
import org.jetel.exception.JetelRuntimeException;
import org.jetel.component.normalize.DataRecordNormalize;

public class GetJavaTypes extends DataRecordNormalize {

	@Override
	public int transform(DataRecord source, DataRecord target, int idx) {
		target.reset();
		target.getField("fieldName").setValue(source.getField(idx).getMetadata().getName());
		target.getField("fieldType").setValue(source.getField(idx).getMetadata().getDataType().toString());
		target.getField("fieldTypeJava").setValue(source.getField(idx).getValue().getClass().getCanonicalName());

		return DataRecordNormalize.OK;
	}

	@Override
	public int count(DataRecord source) {
		return this.sourceMetadata.getNumFields();
	}
}
