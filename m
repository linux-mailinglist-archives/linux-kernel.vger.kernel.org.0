Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F9194DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 01:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC0AYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 20:24:38 -0400
Received: from mx.flatmax.org ([13.55.16.222]:51422 "EHLO mx.flatmax.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgC0AYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 20:24:38 -0400
X-Greylist: delayed 1635 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 20:24:36 EDT
Received: from 41.68.233.220.static.exetel.com.au ([220.233.68.41] helo=[192.168.1.51])
        by mx.flatmax.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <flatmax@flatmax.org>)
        id 1jHcMl-0007WX-6U; Fri, 27 Mar 2020 10:56:51 +1100
Subject: Re: [PATCH] ASoC: bcm2835-i2s: substream alignment now independent in
 hwparams
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        alsa-devel@alsa-project.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org
References: <20200324090823.20754-1-flatmax@flatmax.org>
From:   Matt Flax <flatmax@flatmax.org>
Message-ID: <d0684926-3f7a-0b97-a298-4088925442a4@flatmax.org>
Date:   Fri, 27 Mar 2020 10:56:50 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200324090823.20754-1-flatmax@flatmax.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Score: -1.9 (-)
X-Spam-Report: Spam detection software, running on the system "mx.flatmax.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Should this patch be handled through the ALSA team the R.
   Pi team or the BCM team ? thanks Matt 
 Content analysis details:   (-1.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  0.0 TVD_RCVD_IP            Message was received from an IP address
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was
                             blocked.  See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: flatmax.org]
  1.0 MISSING_HEADERS        Missing To: header
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Should this patch be handled through the ALSA team the R. Pi team or the 
BCM team ?


thanks

Matt

On 24/3/20 8:08 pm, Matt Flax wrote:
> Substream sample alignment was being set in hwparams for both
> substreams at the same time. This became a problem when	the Audio
> Injector isolated sound card needed to offset sample alignment
> for high sample	rates. The latency difference between playback
> and capture occurs because of the digital isolation chip
> propagation time, particularly when the codec is master and
> the DAC return is twice delayed.
>
> This patch sets sample alignment registers  based on the substream
> direction in hwparams. This gives the machine driver more control
> over sample alignment in the bcm2835 i2s driver.
>
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---
>   sound/soc/bcm/bcm2835-i2s.c | 36 +++++++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
> index e6a12e271b07..9db542699a13 100644
> --- a/sound/soc/bcm/bcm2835-i2s.c
> +++ b/sound/soc/bcm/bcm2835-i2s.c
> @@ -493,11 +493,6 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
>   		return -EINVAL;
>   	}
>   
> -	bcm2835_i2s_calc_channel_pos(&rx_ch1_pos, &rx_ch2_pos,
> -		rx_mask, slot_width, data_delay, odd_slot_offset);
> -	bcm2835_i2s_calc_channel_pos(&tx_ch1_pos, &tx_ch2_pos,
> -		tx_mask, slot_width, data_delay, odd_slot_offset);
> -
>   	/*
>   	 * Transmitting data immediately after frame start, eg
>   	 * in left-justified or DSP mode A, only works stable
> @@ -508,19 +503,26 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
>   			"Unstable slave config detected, L/R may be swapped");
>   
>   	/*
> -	 * Set format for both streams.
> -	 * We cannot set another frame length
> -	 * (and therefore word length) anyway,
> -	 * so the format will be the same.
> +	 * Set format on a per stream basis.
> +	 * The alignment format can be different depending on direction.
>   	 */
> -	regmap_write(dev->i2s_regmap, BCM2835_I2S_RXC_A_REG,
> -		  format
> -		| BCM2835_I2S_CH1_POS(rx_ch1_pos)
> -		| BCM2835_I2S_CH2_POS(rx_ch2_pos));
> -	regmap_write(dev->i2s_regmap, BCM2835_I2S_TXC_A_REG,
> -		  format
> -		| BCM2835_I2S_CH1_POS(tx_ch1_pos)
> -		| BCM2835_I2S_CH2_POS(tx_ch2_pos));
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		bcm2835_i2s_calc_channel_pos(&rx_ch1_pos, &rx_ch2_pos,
> +			rx_mask, slot_width, data_delay, odd_slot_offset);
> +		regmap_write(dev->i2s_regmap, BCM2835_I2S_RXC_A_REG,
> +			  format
> +			| BCM2835_I2S_CH1_POS(rx_ch1_pos)
> +			| BCM2835_I2S_CH2_POS(rx_ch2_pos));
> +	}
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		bcm2835_i2s_calc_channel_pos(&tx_ch1_pos, &tx_ch2_pos,
> +			tx_mask, slot_width, data_delay, odd_slot_offset);
> +		regmap_write(dev->i2s_regmap, BCM2835_I2S_TXC_A_REG,
> +			  format
> +			| BCM2835_I2S_CH1_POS(tx_ch1_pos)
> +			| BCM2835_I2S_CH2_POS(tx_ch2_pos));
> +	}
>   
>   	/* Setup the I2S mode */
>   
