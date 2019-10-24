Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A84E36DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 17:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409703AbfJXPlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 11:41:31 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49731 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405824AbfJXPla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:41:30 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9OFeiOc016236;
        Thu, 24 Oct 2019 17:41:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=LV706jSi2f+46Tg4TfZ6VFseIWlovRjlpB2QmvImJLM=;
 b=Lvr6UMzPZIbaUCdsuXyTfwXFrY9t3F2VK2AkIkERTLYyOwsPzXtIf4Aa3yFAUcVqaEMI
 DuQHh9FaNMTMLbvKd0MAMXA7LgyvBZexsQ75zcv7eWNF8V5ttSevNh5X+oq34RzKtxpJ
 ytA4YhXmydgdIzo+ikwYb/wuhgZF0c6JCxJIaP4QMPWQWRfOWduET4d1ciKMGhn26+As
 BxIqlqS3OFq9mdsWMSoPi7RDEBZFQdu+AZA2IB205jUdxIT/8gLeFQFWwMT3F8GqF2XP
 lgSwocuJioc0Lfn9mlmFJhw7eH+as/+0HyjqU6wQ9LKE0XLGYn//gsqggJnuosuLtwVM gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vt9s1tp5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 17:41:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 177D0100038;
        Thu, 24 Oct 2019 17:41:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0BDFA2C6E5F;
        Thu, 24 Oct 2019 17:41:25 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 24 Oct 2019 17:41:24
 +0200
From:   Pascal Paillet <p.paillet@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.paillet@st.com>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/1] Enable stm32_pwr regulator driver for stm32mp157
Date:   Thu, 24 Oct 2019 17:41:20 +0200
Message-ID: <20191024154121.8503-1-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_09:2019-10-23,2019-10-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the STM32 PWR regulator driver for stm32mp157 machine.

Pascal Paillet (1):
  regulator: stm32_pwr: Enable driver for stm32mp157

 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.17.1

