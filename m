Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF1CC06DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfI0OBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 10:01:46 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36787 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfI0OBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:01:46 -0400
Received: by mail-wr1-f43.google.com with SMTP id y19so2893096wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=RKXGJO67bSVwcMxapZtp3HQ/bxJlidvJPusHAL8DCEE=;
        b=QwhnczTvZSqyKTVGhoX1/k1O5JUcXrinwvEVzw/2GMgtscxYn2JQt+cGP8Y/nPnben
         Kx2+3Klv2P28K2aOxrY/0eRB2f5cU9PyoIlwiyjwYE6C1xryj4SNW5marQTWm6VzUGhh
         w0innW9sm1+Zk4kJlhf+Emm/+95/3hyFVnnxvzewx+UvSwA35qpjwyxBU32dYs6dZ/jQ
         eGEwyNz++7qiZYmA+uYRyv4jnrPCgSZ8F5yZr0FcnUJr4bjo4uAREFH3G4cdK+frUjnG
         48EV8cVtDuYd09+Qk/tnwG3BrPSv+wlJbNh/BWXPqcoSUEwndWxTf69UZjKcWpsK5NTa
         q8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=RKXGJO67bSVwcMxapZtp3HQ/bxJlidvJPusHAL8DCEE=;
        b=f6dK5ILjZUhb/s28G2d+UJv4gIquvaTPQneJOeAxoho9BC4xBxnfaTrYpAjc/mGu+k
         25v84SkgWMFo4tv8/7sGzNYI1CdrHcjeHsyaEP+qHPixgRsiXsveUaeG6BGaDUuaiNv4
         YrG9KkULCwZKadTVsd+Q0ySgb8RTS1EnYkk8bNdGha0k99tpkjXj6BG8fVL0CAivFhwO
         JyTx/F+2tpQIx/fVtCl0zC9qXucXrqCG7KYkkUSOOPxe9WxDSDG1ZQSLvX/PcSEOpjFI
         xGdrx2bUJVj9TxVpyUFShaVn4fp+z1hF+bjGFeJt0W1oWNeos0Gc7FYj8J8N5WBx67CC
         gqLA==
X-Gm-Message-State: APjAAAXG9D2zspIdsmjDZNpUx8v8Ukf5lQkb5I7IhE4zPDOr91flPk1G
        1+uir4onHAnA2Az6uJKIiG/WAg==
X-Google-Smtp-Source: APXvYqzOuKYxBRVn2GcuMubPwocxzt5Z1JaAXuyzDNij4c6n2cyhfFh4z6NQyBhBElqMeCRehy8T6A==
X-Received: by 2002:a5d:4f04:: with SMTP id c4mr2443279wru.98.1569592904391;
        Fri, 27 Sep 2019 07:01:44 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f10sm4276096wml.4.2019.09.27.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 07:01:43 -0700 (PDT)
References: <20190924153356.24103-1-jbrunet@baylibre.com> <20190924153356.24103-8-jbrunet@baylibre.com> <22415bc6-2550-d927-93e0-88f6aa2bee9d@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] clk: meson: axg_audio: add sm1 support
In-reply-to: <22415bc6-2550-d927-93e0-88f6aa2bee9d@baylibre.com>
Date:   Fri, 27 Sep 2019 16:01:42 +0200
Message-ID: <1jftkh25yx.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 27 Sep 2019 at 11:36, Neil Armstrong <narmstrong@baylibre.com> wrote:

>>  
>>  static struct clk_regmap spdifout_clk_sel =
>>  	AUD_MST_MCLK_MUX(spdifout_clk, AUDIO_CLK_SPDIFOUT_CTRL);
>> @@ -502,7 +522,6 @@ static struct clk_regmap tdmout_c_lrclk =
>>  	AUD_TDM_LRLCK(out_c, AUDIO_CLK_TDMOUT_C_CTRL);
>>  
>>  /* AXG/G12A Clocks */
>> -
>
> Spurious line remove

Oops, I'll migrate that to the appropriate change, Thx

>
>>  static struct clk_hw axg_aud_top = {
>>  	.init = &(struct clk_init_data) {
>>  		/* Provide aud_top signal name on axg and g12a */
>> @@ -573,7 +592,185 @@ static struct clk_regmap g12a_tdm_sclk_pad_2 = AUD_TDM_PAD_CTRL(
>
> Small nit, but:
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

