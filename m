Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4C825451
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 17:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfEUPqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 11:46:21 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9932 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728571AbfEUPqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:46:21 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LFbDtR021412;
        Tue, 21 May 2019 17:46:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=YLY8K4JAd9i9hkG4XK+nEONRnmj7dXy3ssCpW/hpiHg=;
 b=fsRoIo34yyhwhQKEdr3dXtKsVh1WJDXghsUyYmymUgDp6ooQroQ6lGwGbrcx70nVuUSc
 bpNuqvPhPy3KWactK5mZN+lG7xulo2jJwx2LEmgY4wBIUTa7nvMaHPFPrkAXXAAM94S6
 mFq7tCMJrUMfVEDzPs7yjy1DDSMjCGe3oZWxMIuh88hRB5ucBW0O0qdO60sNEB96/hXb
 UUzgA92guS6WIGzvp9vrs8DGyoZRMxXE6ADQC3QMR9IO/m9WD3zUphDm4LTrs3DweLnt
 rloxCf1gHObadLs8cOG0SET+aSx3Nr4MbTYhKiuC/Qd3QitYuHbLxBjA3chFyu2Bmve4 IQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sj7h0tkvu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 May 2019 17:46:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 090E138;
        Tue, 21 May 2019 15:46:07 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD2C72CE6;
        Tue, 21 May 2019 15:46:06 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 May
 2019 17:46:06 +0200
Received: from localhost (10.201.23.31) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 May 2019 17:46:06
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Erwan Le Ray" <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/7] usart various fixes for STM32
Date:   Tue, 21 May 2019 17:45:40 +0200
Message-ID: <1558453547-22866-1-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series delivers fixes in various uart functions of stm32-usart
driver.

Erwan Le Ray (7):
  serial: stm32: fix word length configuration
  serial: stm32: fix rx error handling
  serial: stm32: fix rx data length when parity enabled
  serial: stm32: fix transmit_chars when tx is stopped
  serial: stm32: Add support of TC bit status check
  serial: stm32: fix wakeup source initialization
  serial: stm32: fix the get_irq error case

 drivers/tty/serial/stm32-usart.c | 221 ++++++++++++++++++++++++++-------------
 drivers/tty/serial/stm32-usart.h |  14 +--
 2 files changed, 152 insertions(+), 83 deletions(-)

-- 
1.9.1

