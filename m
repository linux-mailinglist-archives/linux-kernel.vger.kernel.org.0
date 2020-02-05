Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E445415244B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 01:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgBEAun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 19:50:43 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56464 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbgBEAun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:50:43 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 83A21891AB;
        Wed,  5 Feb 2020 13:50:40 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580863840;
        bh=iLQuuWxB6Jaimww983jVFno7XOVIYbz6GG94PK9PCmE=;
        h=From:To:Cc:Subject:Date;
        b=fqOa1SfKVyL4TKjskbHcq7nLfyXIjmbV3U/4zPnu0C2Smrt3e+iqbf0VKjPGu5E7R
         +85Fl7dkaYbkibyWtYUagvK0ikzKCciwm2U5T3wqPFUdzYheNh/Z48klHQEZloXeRe
         DrvdiBy0FJiGCon9ndiBMqLo0alMhEADTXU8Sq4GUFl90ZxT3Z90Yk2f/zriNklA9A
         s4D1KikvCmu6OSXlJLKk1N2g/01xL0tuqKk4gQcnBgECTA7KCm19DBNR0QTthQVJEq
         NYCL4lY4htGvKkhi820VmuWOHi3M1djURQBdBcmGpErkQugCg0Zx60fn+baxYH0V49
         DQoRwf7GM9zPw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e3a11600000>; Wed, 05 Feb 2020 13:50:40 +1300
Received: from henrys-dl.ws.atlnz.lc (henrys-dl.ws.atlnz.lc [10.33.23.26])
        by smtp (Postfix) with ESMTP id 9054013EEDE;
        Wed,  5 Feb 2020 13:50:39 +1300 (NZDT)
Received: by henrys-dl.ws.atlnz.lc (Postfix, from userid 1052)
        id 0C5184E9819; Wed,  5 Feb 2020 13:50:40 +1300 (NZDT)
From:   Henry Shen <henry.shen@alliedtelesis.co.nz>
To:     mark.rutland@arm.com
Cc:     vadimp@mellanox.com, linux-kernel@vger.kernel.org,
        Henry Shen <henry.shen@alliedtelesis.co.nz>
Subject: [PATCH] dt-bindings: Add TI LM73 as a trivial device
Date:   Wed,  5 Feb 2020 13:49:55 +1300
Message-Id: <20200205004956.28719-1-henry.shen@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Texas Instruments LM73 is a digital temperature sensor with 2-wire
interface. Add LM73 as a trivial device.

Henry Shen (1):
  dt-bindings: Add TI LM73 as a trivial device

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

--=20
2.25.0

