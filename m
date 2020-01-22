Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD961451C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 10:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgAVJ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 04:56:15 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:9582 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729991AbgAVJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:56:12 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00M9sCgL016050;
        Wed, 22 Jan 2020 10:56:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=T7e1eVxP0lShk3STvXZZuobRd1gVWOJ0YD2b4TZoSp0=;
 b=Yo2nCzTjAokO5nSSlGrBJ2y0My66c9Q7y1UjojgXAYHvipy1cnox4qXUNVWQ9g0zTdha
 bYYF0DMuKZsyXvrbb25zXFwj2zl52QC33dmEPAja8nZGKeJcvadcyCh0oUxoD8JXH6Mc
 maRZtdoBF2HFFlO6ORFBNkUzm0WLD2TmEb/+xKCFsPl3Bfkv6zYv4V6+kSLU5pkdkVjG
 D99mrtE4RyVJZPCBJL3+2vNcIPNcdL602EklMh7nJ4QStc4SebKOX0hzNaUV+FA9sqoU
 zztakSZvE/l7yxFhDlrGy+tHc6fm8PNmsi9qGFOKUIJVw/Bf3XmDf7LwvUj4WYxQTLHU fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkr1e3rmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 10:56:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 87251100034;
        Wed, 22 Jan 2020 10:56:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 75ACA2AD14D;
        Wed, 22 Jan 2020 10:56:00 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 22 Jan 2020 10:55:59
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <fabrice.gasnier@st.com>,
        <erwan.leray@st.com>, Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 0/2] Convert STM32 UART bindings to yaml
Date:   Wed, 22 Jan 2020 10:55:56 +0100
Message-ID: <20200122095558.22553-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this series is to convert STM32 UART bindings to json-schema.
Since STM32 UART bindings use rs485 bindings it is also the opportunity
to convert them to json-schema.

version 2:
- remove types inside rs485-rts-delay property and add a maximum for delay
  values

Benjamin Gaignard (2):
  dt-bindings: serial: Convert rs485 bindings to json-schema
  dt-bindings: serial: Convert STM32 UART to json-schema

 Documentation/devicetree/bindings/serial/rs485.txt | 32 +--------
 .../devicetree/bindings/serial/rs485.yaml          | 45 ++++++++++++
 .../devicetree/bindings/serial/st,stm32-uart.yaml  | 80 ++++++++++++++++++++++
 .../devicetree/bindings/serial/st,stm32-usart.txt  | 57 ---------------
 4 files changed, 126 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/rs485.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt

-- 
2.15.0

