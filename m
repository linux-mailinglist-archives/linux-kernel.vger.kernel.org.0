Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5CA174EBF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 18:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgCARq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 12:46:57 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:39032 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCARq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 12:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583084814; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=iTJKUpTGa8KTnniCeqr5P5m/oieH5vHpFi8rEsqTDlk=;
        b=mOnOWAS5v9jlYSThJDS58XkMEcWCw2yjJBfI/1tlw7xuc5Nev/fKVKksVblOz+W/fDhhQM
        +6nz0JGoLswKLfArKjxtO+5BMg8dw0fhiN1cO6IxcjaRobid8DU6WvmTT4qreZLhIvcRia
        iWAOrwNMhx5NdQWeL3krS0ao7XsntCU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/1] Convert ingenic,tcu.txt to YAML
Date:   Sun,  1 Mar 2020 14:46:35 -0300
Message-Id: <20200301174636.63446-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel:

Could you take this patch into your tree (provided Rob acks it)? Since
commit fe6c2d6a8068 ("dt-bindings: timer: Add X1000 bindings.") modified
the .txt already, going through your tree would avoid a merge conflict.

Cheers,
-Paul

Paul Cercueil (1):
  dt-bindings: timer: Convert ingenic,tcu.txt to YAML

 .../devicetree/bindings/timer/ingenic,tcu.txt | 138 ----------
 .../bindings/timer/ingenic,tcu.yaml           | 235 ++++++++++++++++++
 2 files changed, 235 insertions(+), 138 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml

-- 
2.25.1

