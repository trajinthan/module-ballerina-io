// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
import ballerina/test;

@test:Config {}
function testWriteXml() {
    string filePath = TEMP_DIR + "xmlCharsFile1.xml";
    xml content = xml `<CATALOG>
                       <CD>
                           <TITLE>Empire Burlesque</TITLE>
                           <ARTIST>Bob Dylan</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>Columbia</COMPANY>
                           <PRICE>10.90</PRICE>
                           <YEAR>1985</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Hide your heart</TITLE>
                           <ARTIST>Bonnie Tyler</ARTIST>
                           <COUNTRY>UK</COUNTRY>
                           <COMPANY>CBS Records</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1988</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Greatest Hits</TITLE>
                           <ARTIST>Dolly Parton</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>RCA</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1982</YEAR>
                       </CD>
                   </CATALOG>`;
    var byteChannel = openWritableFile(filePath);
    if (byteChannel is WritableByteChannel) {
        WritableCharacterChannel characterChannel = new WritableCharacterChannel(byteChannel, DEFAULT_ENCODING);
        var result = characterChannel.writeXml(content);
        if (result is Error) {
            test:assertFail(msg = result.message());
        }

        var closeResult = characterChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = byteChannel.message());
    }
}

@test:Config {dependsOn: [testWriteXml]}
function testReadXml() {
    string filePath = TEMP_DIR + "xmlCharsFile1.xml";
    xml expectedXml = xml `<CATALOG>
                       <CD>
                           <TITLE>Empire Burlesque</TITLE>
                           <ARTIST>Bob Dylan</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>Columbia</COMPANY>
                           <PRICE>10.90</PRICE>
                           <YEAR>1985</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Hide your heart</TITLE>
                           <ARTIST>Bonnie Tyler</ARTIST>
                           <COUNTRY>UK</COUNTRY>
                           <COMPANY>CBS Records</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1988</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Greatest Hits</TITLE>
                           <ARTIST>Dolly Parton</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>RCA</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1982</YEAR>
                       </CD>
                   </CATALOG>`;
    var byteChannel = openReadableFile(filePath);
    if (byteChannel is ReadableByteChannel) {
        ReadableCharacterChannel characterChannel = new ReadableCharacterChannel(byteChannel, DEFAULT_ENCODING);
        var result = characterChannel.readXml();
        if (result is xml) {
            test:assertEquals(result, expectedXml, msg = "Found unexpected output");
        } else {
            test:assertFail(msg = result.message());
        }

        var closeResult = characterChannel.close();
        if (closeResult is Error) {
            test:assertFail(msg = closeResult.message());
        }
    } else {
        test:assertFail(msg = byteChannel.message());
    }
}

@test:Config {}
function testFileWriteXml() {
    string filePath = TEMP_DIR + "xmlCharsFile2.xml";
    xml content = xml `<CATALOG>
                       <CD>
                           <TITLE>Empire Burlesque</TITLE>
                           <ARTIST>Bob Dylan</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>Columbia</COMPANY>
                           <PRICE>10.90</PRICE>
                           <YEAR>1985</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Hide your heart</TITLE>
                           <ARTIST>Bonnie Tyler</ARTIST>
                           <COUNTRY>UK</COUNTRY>
                           <COMPANY>CBS Records</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1988</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Greatest Hits</TITLE>
                           <ARTIST>Dolly Parton</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>RCA</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1982</YEAR>
                       </CD>
                   </CATALOG>`;
    var result = fileWriteXml(filePath, content);
    if (result is Error) {
        test:assertFail(msg = result.message());
    }
}

@test:Config {dependsOn: [testFileWriteXml]}
function testFileReadXml() {
    string filePath = TEMP_DIR + "xmlCharsFile2.xml";
    xml expectedXml = xml `<CATALOG>
                       <CD>
                           <TITLE>Empire Burlesque</TITLE>
                           <ARTIST>Bob Dylan</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>Columbia</COMPANY>
                           <PRICE>10.90</PRICE>
                           <YEAR>1985</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Hide your heart</TITLE>
                           <ARTIST>Bonnie Tyler</ARTIST>
                           <COUNTRY>UK</COUNTRY>
                           <COMPANY>CBS Records</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1988</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Greatest Hits</TITLE>
                           <ARTIST>Dolly Parton</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>RCA</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1982</YEAR>
                       </CD>
                   </CATALOG>`;
    var result = fileReadXml(filePath);
    if (result is xml) {
        test:assertEquals(result, expectedXml, msg = "Found unexpected output");
    } else {
        test:assertFail(msg = result.message());
    }
}

@test:Config {}
function testFileWriteXmlWithOverwrite() {
    string filePath = TEMP_DIR + "xmlCharsFile3.xml";
    xml content1 = xml `<CATALOG>
                       <CD>
                           <TITLE>Empire Burlesque</TITLE>
                           <ARTIST>Bob Dylan</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>Columbia</COMPANY>
                           <PRICE>10.90</PRICE>
                           <YEAR>1985</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Hide your heart</TITLE>
                           <ARTIST>Bonnie Tyler</ARTIST>
                           <COUNTRY>UK</COUNTRY>
                           <COMPANY>CBS Records</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1988</YEAR>
                       </CD>
                       <CD>
                           <TITLE>Greatest Hits</TITLE>
                           <ARTIST>Dolly Parton</ARTIST>
                           <COUNTRY>USA</COUNTRY>
                           <COMPANY>RCA</COMPANY>
                           <PRICE>9.90</PRICE>
                           <YEAR>1982</YEAR>
                       </CD>
                   </CATALOG>`;
    xml content2 = xml `<USER><NAME>Mary Jane</NAME><AGE>33</AGE></USER>`;
    // Check content 01
    var result1 = fileWriteXml(filePath, content1);
    if (result1 is Error) {
        test:assertFail(msg = result1.message());
    }
    var result2 = fileReadXml(filePath);
    if (result2 is xml) {
        test:assertEquals(result2, content1);
    } else {
        test:assertFail(msg = result2.message());
    }

    // Check content 02
    var result3 = fileWriteXml(filePath, content2);
    if (result3 is Error) {
        test:assertFail(msg = result3.message());
    }
    var result4 = fileReadXml(filePath);
    if (result4 is xml) {
        test:assertEquals(result4, content2);
    } else {
        test:assertFail(msg = result4.message());
    }
}

@test:Config {}
function testFileWriteDocTypedXml() {
    string filePath = TEMP_DIR + "xmlCharsFile4.xml";
    string resultFilePath = "tests/resources/expectedXmlCharsFile4.xml";
    string originalFilePath = "tests/resources/originalXmlContent.xml";

    xml content = checkpanic fileReadXml(originalFilePath);
    string doctypeValue = "<!DOCTYPE note SYSTEM \"Note.dtd\">";
    var writeResult = fileWriteXml(filePath, content, doctype={system:"Note.dtd"});
    if (writeResult is Error) {
        test:assertFail(msg = writeResult.message());
    }
    string readResult = checkpanic fileReadString(filePath);
    string expectedResult = checkpanic fileReadString(resultFilePath);
    test:assertEquals(readResult, expectedResult);
}

@test:Config {}
function testFileWriteDocTypedWithMultiRoots() {
    string filePath = TEMP_DIR + "xmlCharsFile4.xml";
    string originalFilePath = "tests/resources/originalXmlContent.xml";

    xml content = checkpanic fileReadXml(originalFilePath);
    xml x1 = xml `<body>Don't forget me this weekend!</body>`;

    var writeResult = fileWriteXml(filePath, xml:concat(content, x1));
    if (writeResult is Error) {
        test:assertEquals(writeResult.message(), "The XML Document can only contains single root");
    } else {
        test:assertFail("Expected ConfigurationError not found");
    }
}

@test:Config {}
function testFileWriteDocTypedWithAppend() {
    string filePath = TEMP_DIR + "xmlCharsFile4.xml";
    string originalFilePath = "tests/resources/originalXmlContent.xml";

    xml content = checkpanic fileReadXml(originalFilePath);
    var writeResult = fileWriteXml(filePath, content, fileWriteOption=APPEND);
    if (writeResult is Error) {
        test:assertEquals(writeResult.message(), "The file append operation is not allowed for Document Entity");
    } else {
        test:assertFail("Expected ConfigurationError not found");
    }
}

@test:Config {}
function testFileAppendDocTypedXml() {
    string filePath = TEMP_DIR + "xmlCharsFile5.xml";
    string originalFilePath = "tests/resources/originalXmlContent.xml";
    string resultFilePath = "tests/resources/expectedXmlCharsFile5.xml";

    xml content1 = checkpanic fileReadXml(originalFilePath);
    xml content2 = xml `<body>Don't forget me this weekend!</body>`;
    var writeResult = fileWriteXml(filePath, content1);
    if (writeResult is Error) {
        test:assertFail(msg = writeResult.message());
    }
    var appendResult = fileWriteXml(filePath, content2, fileWriteOption=APPEND, xmlEntityType=EXTERNAL_PARSED_ENTITY);
    if (appendResult is Error) {
        test:assertFail(msg = appendResult.message());
    }
    string readResult = checkpanic fileReadString(filePath);
    string expectedResult = checkpanic fileReadString(resultFilePath);
    test:assertEquals(readResult, expectedResult);
}

@test:Config {}
function testFileWriteDocTypedXmlWithInternalSubset() {
    string filePath = TEMP_DIR + "xmlCharsFile6.xml";
    string originalFilePath = "tests/resources/originalXmlContent.xml";
    string resultFilePath = "tests/resources/expectedXmlCharsFile6.xml";

    xml content = checkpanic fileReadXml(originalFilePath);
    string startElement = "<!DOCTYPE note ";
    string endElement = ">";
    string internalSub = string `[
        <!ELEMENT note (to,from,heading,body)>
        <!ELEMENT to (#PCDATA)>
        <!ELEMENT from (#PCDATA)>
        <!ELEMENT heading (#PCDATA)>
        <!ELEMENT body (#PCDATA)>
    ]`;
    var writeResult = fileWriteXml(filePath, content, doctype={internalSubset: internalSub});
    if (writeResult is Error) {
        test:assertFail(msg = writeResult.message());
    }
    string readResult = checkpanic fileReadString(filePath);
    string expectedResult = checkpanic fileReadString(resultFilePath);
    test:assertEquals(readResult, expectedResult);
}

@test:Config {}
function testFileWriteDocTypedXmlWithPrioritizeInternalSubset() {
    string filePath = TEMP_DIR + "xmlCharsFile6.xml";
    string originalFilePath = "tests/resources/originalXmlContent.xml";
    string resultFilePath = "tests/resources/expectedXmlCharsFile6.xml";

    xml content = checkpanic fileReadXml(originalFilePath);
    string startElement = "<!DOCTYPE note ";
    string endElement = ">";
    string systemId = "http://www.w3.org/TR/html4/loose.dtd";
    string internalSub = string `[
        <!ELEMENT note (to,from,heading,body)>
        <!ELEMENT to (#PCDATA)>
        <!ELEMENT from (#PCDATA)>
        <!ELEMENT heading (#PCDATA)>
        <!ELEMENT body (#PCDATA)>
    ]`;
    var writeResult = fileWriteXml(filePath, content, doctype={internalSubset: internalSub, system: systemId});
    if (writeResult is Error) {
        test:assertFail(msg = writeResult.message());
    }
    string readResult = checkpanic fileReadString(filePath);
    string expectedResult = checkpanic fileReadString(resultFilePath);
    test:assertEquals(readResult, expectedResult);
}

@test:Config {}
function testFileWriteDocTypedXmlWithPublic() {
    string filePath = TEMP_DIR + "xmlCharsFile7.xml";
    string originalFilePath = "tests/resources/originalXmlContent.xml";
    string resultFilePath = "tests/resources/expectedXmlCharsFile7.xml";

    xml content = checkpanic fileReadXml(originalFilePath);
    string doctypeValue = "<!DOCTYPE note PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">";
    string publicId = "-//W3C//DTD HTML 4.01 Transitional//EN";
    string systemId = "http://www.w3.org/TR/html4/loose.dtd";
    var writeResult = fileWriteXml(filePath, content, doctype={system: systemId, 'public: publicId});
    if (writeResult is Error) {
        test:assertFail(msg = writeResult.message());
    }
    string readResult = checkpanic fileReadString(filePath);
    string expectedResult = checkpanic fileReadString(resultFilePath);
    test:assertEquals(readResult, expectedResult);
}
