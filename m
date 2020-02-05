Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4C15245C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 02:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgBEBHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 20:07:09 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56564 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgBEBHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:07:09 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 66EE2891AC;
        Wed,  5 Feb 2020 14:07:07 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580864827;
        bh=Z3qZ/SaUATANCUcRxrW2wwh24bjRw9uNImzatMioAlY=;
        h=From:To:Cc:Subject:Date;
        b=A5kW3j+1xc7+Wy3yqFb4N4AkeTEz3QMyt1NgkOvD4kAn0NU3y2RK35SAP1Vl6ord7
         5/Ekq438AzmKQyxd6b5ATGafA20Jjjr/Iy3YwXb2t++COk+twR/qt+mYJE0t5jcPUZ
         HfDwQ0/GzsEEO67+ctuQW9xLUlEwo2Og8q/aduPT39ZD7xhRMXRTUFglJWZJ4UwfH7
         2Y0z0PvU3DxxUl/HELvixJyURLQSfoU3Bzaiu5y9bHg8ssgkipvCgzuEB9YOhrF4E+
         XdFYYY0/Wk+A95ZTCam7B8oQEapObnX7Dn3l05KXK/3I7lBS4aBZLXKOVF1G+7eciS
         3s79t35cFYcww==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e3a153b0001>; Wed, 05 Feb 2020 14:07:07 +1300
Received: from henrys-dl.ws.atlnz.lc (henrys-dl.ws.atlnz.lc [10.33.23.26])
        by smtp (Postfix) with ESMTP id B8FC613EEDE;
        Wed,  5 Feb 2020 14:07:06 +1300 (NZDT)
Received: by henrys-dl.ws.atlnz.lc (Postfix, from userid 1052)
        id 35E3E4E9850; Wed,  5 Feb 2020 14:07:07 +1300 (NZDT)
From:   Henry Shen <henry.shen@alliedtelesis.co.nz>
To:     guillaume.ligneul@gmail.com
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Henry Shen <henry.shen@alliedtelesis.co.nz>
Subject: [PATCH] hwmon: (lm73) Add support for of_match_table
Date:   Wed,  5 Feb 2020 14:06:56 +1300
Message-Id: <20200205010657.29483-1-henry.shen@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the of_match_table.

Henry Shen (1):
  hwmon: (lm73) Add support for of_match_table

 drivers/hwmon/lm73.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

--=20
2.25.0

