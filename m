Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE65110EEBA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 18:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfLBRsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 12:48:41 -0500
Received: from node.akkea.ca ([192.155.83.177]:34684 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfLBRsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:48:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id D24274E200E;
        Mon,  2 Dec 2019 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575308920; bh=qfKdNZ1HBtViTTD5XHaCa9z4hvXMR4eI/MrZct97QqY=;
        h=From:To:Cc:Subject:Date;
        b=Qa0+r9XiQhfbN0jBdjUEoNVNnhYSz41LKL/xNHwYfsxcZHN7V4F5B3vsUAacwh+ns
         nADerYPHg1nVDYeHK8NLSEVFX/H4TDgEtEYWQUpqXIxxQrCRxmwki0NlCRTVZvjzVy
         sOjekbkH75Cp9Ge7px6MdRYZg+ozDIJftgaFfPG8=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JuvcBJccax_v; Mon,  2 Dec 2019 17:48:40 +0000 (UTC)
Received: from thinkpad-tablet.cg.shawcable.net (S0106905851b613e9.cg.shawcable.net [70.77.244.40])
        by node.akkea.ca (Postfix) with ESMTPSA id 825844E2003;
        Mon,  2 Dec 2019 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575308920; bh=qfKdNZ1HBtViTTD5XHaCa9z4hvXMR4eI/MrZct97QqY=;
        h=From:To:Cc:Subject:Date;
        b=Qa0+r9XiQhfbN0jBdjUEoNVNnhYSz41LKL/xNHwYfsxcZHN7V4F5B3vsUAacwh+ns
         nADerYPHg1nVDYeHK8NLSEVFX/H4TDgEtEYWQUpqXIxxQrCRxmwki0NlCRTVZvjzVy
         sOjekbkH75Cp9Ge7px6MdRYZg+ozDIJftgaFfPG8=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 0/2] Add the broadmobi BM818
Date:   Mon,  2 Dec 2019 10:48:29 -0700
Message-Id: <20191202174831.13638-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The broadmobi uses slightly different parameters from the option modems
so add the paramters and document them.

Angus Ainslie (Purism) (2):
  sound: codecs: gtm601: add Broadmobi bm818 sound profile
  ASoC: gtm601: add the broadmobi interface

 .../devicetree/bindings/sound/gtm601.txt      | 10 +++++--
 sound/soc/codecs/gtm601.c                     | 29 +++++++++++++++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.17.1

