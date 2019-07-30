Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F9E7AC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 17:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbfG3P1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 11:27:38 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50946 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbfG3P1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:27:38 -0400
Received: from [167.98.27.226] (helo=[10.35.6.253])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hsU2H-0000v2-8c; Tue, 30 Jul 2019 16:27:33 +0100
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on diagnostic
 routine
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Annaliese McDermond <nh6z@nh6z.net>,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730124158.GH54126@ediswmail.ad.cirrus.com>
 <e7a879d3-36c2-2df8-97c0-3c4bbd2e7ea2@codethink.co.uk>
 <20190730142010.GG4264@sirena.org.uk>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <99b80b21-fdb4-085f-3380-7df4700bb0ff@codethink.co.uk>
Date:   Tue, 30 Jul 2019 16:27:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730142010.GG4264@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2019 15:20, Mark Brown wrote:
> On Tue, Jul 30, 2019 at 03:04:19PM +0100, Thomas Preston wrote:
>> On 30/07/2019 13:41, Charles Keepax wrote:
> 
>>> This could probably be removed using regmap_multi_reg_write.
> 
>> The problem is that I want to retain the state of the other bits in those
>> registers. Maybe I should make a copy of the backed up state, set the bits
>> I want to off-device, then either:
> 
>> 1. Write the changes with regmap_multi_reg_write
>> 2. Write all six regs again (if my device doesn't support the multi_reg)
> 
> Or make this a regmap function, there's nothing device specific about
> it.
> 

I did wonder why regmap didn't have an multi-update function. If appropriate,
I will add this in.
