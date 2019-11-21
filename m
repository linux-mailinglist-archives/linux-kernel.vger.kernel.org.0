Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95D8105148
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 12:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKULSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 06:18:23 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:37694 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKULSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:18:23 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id E397E3C0579;
        Thu, 21 Nov 2019 12:18:21 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j3j6zWReGeb2; Thu, 21 Nov 2019 12:18:17 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 00F4B3C0022;
        Thu, 21 Nov 2019 12:18:17 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 21 Nov
 2019 12:18:16 +0100
Date:   Thu, 21 Nov 2019 12:18:13 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Nilkanth Ahirrao <external.anilkanth@jp.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: Re: [PATCH] ASoC: rsnd: fix DALIGN register for SSIU
Message-ID: <20191121111813.GA11061@vmlxhi-102.adit-jv.com>
References: <20191118140126.23596-1-erosca@de.adit-jv.com>
 <8736ek7kx8.wl-kuninori.morimoto.gx@renesas.com>
 <20191119104312.GA15556@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191119104312.GA15556@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Superseded by v2:
https://lore.kernel.org/alsa-devel/20191121111023.10976-1-erosca@de.adit-jv.com/

-- 
Best Regards,
Eugeniu
