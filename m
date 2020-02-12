Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87467159F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 04:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgBLDG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 22:06:28 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:39377 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgBLDG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:06:27 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6C51D886BF;
        Wed, 12 Feb 2020 16:06:23 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581476783;
        bh=5Zzd4p0YzB4rRdaFrzvricfO2C3A3m/IaL6u4DjRzpc=;
        h=From:To:Cc:Subject:Date;
        b=h7aDYiZAdE7XwdaiY96S+eNZrCHc+z135II3+n6IEBdPfoB9gENjPA/lxfydY4VWa
         iJ8XY6vvrSft4mI4S9tzkWWs1HgHAyXCy5gQ/FOEe7tK3rABrH0SST7RzEhhZUEV8i
         mHyoceaSfzL+dYJkjCoBKfXTb6bvCrFz+n/FsCKbb22nnN+tys88APHHi/BSR3MxbY
         p7IhYjRDkkPHoMmC0yJ4ZOx/6om17WchS8d4UaFw45WTW82R+lCdm+Teg4fD+AfFx2
         8kuLr1WcZQKT/0m9CL7UIpM91QW3iArqU8UbrombQKtYBIAYLStGMQHkijEco5DZk7
         8s5hbHmgk8fCQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e436baf0000>; Wed, 12 Feb 2020 16:06:23 +1300
Received: from henrys-dl.ws.atlnz.lc (henrys-dl.ws.atlnz.lc [10.33.23.26])
        by smtp (Postfix) with ESMTP id 0E26213EED4;
        Wed, 12 Feb 2020 16:06:23 +1300 (NZDT)
Received: by henrys-dl.ws.atlnz.lc (Postfix, from userid 1052)
        id 351754E1463; Wed, 12 Feb 2020 16:06:23 +1300 (NZDT)
From:   Henry Shen <henry.shen@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        guillaume.ligneul@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        trivial@kernel.org, venture@google.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Henry Shen <henry.shen@alliedtelesis.co.nz>
Subject: [PATCH v2 0/2] (lm73) Add support for of_match_table
Date:   Wed, 12 Feb 2020 16:06:13 +1300
Message-Id: <20200212030615.28537-1-henry.shen@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds documentation and compatible info for the lm73 temperatu=
re
sensor.

Henry Shen (2):
  dt-bindings: Add TI LM73 as a trivial device
  hwmon: (lm73) Add support for of_match_table

 Documentation/devicetree/bindings/trivial-devices.yaml |  2 ++
 drivers/hwmon/lm73.c                                   | 10 ++++++++++
 2 files changed, 12 insertions(+)

--=20
2.25.0

