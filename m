Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6020D1618A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 18:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgBQRUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 12:20:03 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:12303 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQRUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581960000;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=AuhDO2rUbeYJG2tjJ1Rhw+bMLutKYj518pI95sS326Y=;
        b=FbL97z+CmrsRH2lQHdZVMmdOcbrtVYlQG34cd+9V7d/OZAihiG3YkgdemfgXf+LNHs
        mfH/fyrMmPjkq92YOgmAP0OWwZeUg0Ft3MqUflbXKADoYMHdXdOADQkwwpc8mjHUG2pS
        Rp1HplNtaRJhhnHeBlizqhYD+BffoXMcF5jrTCxDIBMQ5VZkMxcwXjQVnZmOxFECDtxn
        7xLxMezykGmstIrci2a/ii7M/TBdIwQDSrLZ55iyEuUzzBVRWZf0JrlQBy/d9Z5D9hJ6
        6Uhzhdf0FKXvlgjLOu/kbR3+mBI54zNuaHOYoyoAoIog5WMy7WH/9sJpGVlSnmeLVo0v
        N8Zg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJKBk/pyQ=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.1.12 AUTH)
        with ESMTPSA id a01fe9w1HHJxeYR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 17 Feb 2020 18:19:59 +0100 (CET)
Date:   Mon, 17 Feb 2020 18:19:47 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sameer Pujar <spujar@nvidia.com>, tiwai@suse.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [alsa-devel] [RFC] ASoC: soc-pcm: crash in snd_soc_dapm_new_dai
Message-ID: <20200217171947.GA24287@gerhold.net>
References: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
 <20200217144120.GA243254@gerhold.net>
 <20200217154301.GN9304@sirena.org.uk>
 <20200217171245.GA881@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217171245.GA881@gerhold.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 06:12:53PM +0100, Stephan Gerhold wrote:
> On Mon, Feb 17, 2020 at 03:43:01PM +0000, Mark Brown wrote:
> > On Mon, Feb 17, 2020 at 03:41:20PM +0100, Stephan Gerhold wrote:
> > 
> > > I'm a bit confused about this patch, isn't SNDRV_PCM_STREAM_PLAYBACK
> > > used for both cpu_dai and codec_dai in the playback case?
> > 
> > It is in the normal case, but with a CODEC<->CODEC link (which was what
> > this was targeting) we need to bodge things by swapping playback and
> > capture on one end of the link.
> 
> I see. Looking at the code again I'm guessing the cause of the crash
> "fixed" by this patch is commit a342031cdd08 ("ASoC: create pcm for
> codec2codec links as well") where the codec2codec case was sort of
> patched in. This is what we had before this patch:
> 
> 		/* Adapt stream for codec2codec links */
> 		struct snd_soc_pcm_stream *cpu_capture = rtd->dai_link->params ?
> 			&cpu_dai->driver->playback : &cpu_dai->driver->capture;
> 		struct snd_soc_pcm_stream *cpu_playback = rtd->dai_link->params ?
> 			&cpu_dai->driver->capture : &cpu_dai->driver->playback;
> 
> This does the swapping you mentioned, so I guess rtd->dai_link->params
> is only set for the codec2codec case?
> 
> 		for_each_rtd_codec_dai(rtd, i, codec_dai) {
> 			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
> 			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
> 				playback = 1;
> 			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_CAPTURE) &&
> 			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
> 				capture = 1;
> 		}
> 
> 		capture = capture && cpu_capture->channels_min;
> 		playback = playback && cpu_playback->channels_min;
> 
> And this does a part of the check in snd_soc_dai_stream_valid(),
> but without the NULL check of cpu_capture/cpu_playback.
> (Maybe that is the cause of the crash.)

Uh, no, I am completely wrong here. :)
cpu_capture/cpu_playback cannot actually be NULL...
I should have looked more carefully at snd_soc_dai_stream_valid()...

But I still wonder if the approach below would be easier?

> 
> From my limited understanding, I would say that a much simpler way to
> implement this would be:
> 
> 	/* Adapt stream for codec2codec links */
> 	int cpu_capture = rtd->dai_link->params ?
> 		SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
> 	int cpu_playback = rtd->dai_link->params ?
> 		SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
> 
> 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
> 		if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
> 		    snd_soc_dai_stream_valid(cpu_dai,   cpu_playback))
> 			playback = 1;
> 		if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_CAPTURE) &&
> 		    snd_soc_dai_stream_valid(cpu_dai,   cpu_capture))
> 			capture = 1;
> 	}
> 
> since snd_soc_dai_stream_valid() does both the NULL-check and the 
> "channels_min" check.
> 
> But I'm really not familar with the codec2codec case and am unable to
> test it :) What do you think?
> 
> Thanks,
> Stephan
