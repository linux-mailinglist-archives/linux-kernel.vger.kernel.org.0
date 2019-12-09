Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF31165D9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 05:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfLIEhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 23:37:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfLIEhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MZaXJJ+0Us/9ZJLhvcDNPUmeTEawsBgwErdJM5IFJdQ=; b=mqwyNEVDcfc/b5Eu5EbdvPmT1
        jaHjUVrqF2WMzTKglBkL3wjXjZwmvuXqmzGEWzEbm6Tg/IT3suAMSuqFrrRRrbZ++0j/oae6QDGC4
        nNm423bVlGvnXMIOODXFY5q+FgT4Vn1xnX+vN53r63p0tf5phN8gzn+0Pp4DdBYtCq3Fd7BBznDx8
        4akKnXjqeg6se08sC8UjjaVmVoQuP0ZN++AVT+1/7qKfIKUaWVddsz8rbkbvdgNf3mZ2GKVBJlEKD
        1c/isI0zqomUQigh6Fyds/F8okQNwdcNt+8sIXpHNlrVu0qXFFoZdnMl8/dDpyAXixGUDQZd10ENM
        2nbkC6uTw==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieAnA-0003up-KT; Mon, 09 Dec 2019 04:37:04 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: fix soc-core.c kernel-doc warning
Message-ID: <2215ee04-e870-5eea-a00c-9a5caf06faae@infradead.org>
Date:   Sun, 8 Dec 2019 20:37:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a kernel-doc warning in soc-core.c by adding notation for
@legacy_dai_naming.

../sound/soc/soc-core.c:2509: warning: Function parameter or member 'legacy_dai_naming' not described in 'snd_soc_register_dai'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/soc-core.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20191209.orig/sound/soc/soc-core.c
+++ linux-next-20191209/sound/soc/soc-core.c
@@ -2508,6 +2508,8 @@ EXPORT_SYMBOL_GPL(snd_soc_unregister_dai
  *
  * @component: The component the DAIs are registered for
  * @dai_drv: DAI driver to use for the DAI
+ * @legacy_dai_naming: if %true, use legacy single-name format;
+ * 	if %false, use multiple-name format;
  *
  * Topology can use this API to register DAIs when probing a component.
  * These DAIs's widgets will be freed in the card cleanup and the DAIs

