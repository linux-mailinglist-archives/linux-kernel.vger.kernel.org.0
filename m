Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3C10240
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 00:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfD3WMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 18:12:18 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:33372 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3WMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:12:17 -0400
Received: by mail-pf1-f176.google.com with SMTP id z28so2444564pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 15:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t1A91VbqK3c3rmC3Vayr6AqXf4GJM9U1CcOpZO0SdRU=;
        b=f2pxPaEwo1XMipVGAf0ROHaKcROWSBZu1hdWrOpwWIE/5PDwTGLFSvUWyEfZehzCoX
         GnA8Ch5BM5Bst+5dc3QfzvFyNlnwVrc4ulkeQ959BtW7PXDDmWlIpOoPCC8weoUGDRYX
         zYInoX9+2APh8P+1rzWbU9YRk6WQ2Io+8iTJe6KlKrYFry5og1VkYN7U303nsFx5xXyc
         5rAZ+484o+BxJqjyPOM5Hj86JDh5JeBm6WXkWy7vrM44Et71o2uh6NaSlB+dMukh378l
         578XRYyPRcxPd3ZcGn4dC+dKrOO10063m2D+k9BBpvG4rkXMWmjOqoELT2UwkEsiOFKF
         Js0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1A91VbqK3c3rmC3Vayr6AqXf4GJM9U1CcOpZO0SdRU=;
        b=YKkJH9yg6aPgJuUZlAnRZMwujwWgbD5Kd+5eFaJgy5DXxgxs1kD6wiLZJOhGb+UZ0M
         AI48ZKoYTorRfnhAK4cLgGcH5pjd4yriyaBelLfJrjesFmUexrtQys3qwOtc5PWLeB0N
         aCwVFrp/hy+6HFyVMTaN63AVAOEhBhOVYDkHccQ90chn7+3Rz5NLitx3jnf1Rz90kRS1
         EJ/ecPFWDaVbDMcUa1Yaw0RmDtWd02+iu4iixDHBr4p6G3jJv1YGJ7XX6J8+raGhxvkg
         ce9Gdpq48HqhFOYB1Bkpt+9NtTSmfMQErat6PQ/479RXSY4ETJrMuJwryXtBF0Pf5Joi
         GWHQ==
X-Gm-Message-State: APjAAAWdTeh9oXXew6SXRlpkK//59FilZGA1Q6rD8zo/FeQrztyYm2o/
        VOnrN7Pe3R+UeuKnV9lDqY4VxroQ22EtLg==
X-Google-Smtp-Source: APXvYqxAfmnvJ+NJgPRvSHpMMaJ1teBBvFl4KXdpLFc6lO5j7TDU7GYYOdkMrjYJZRQFX9cjNlADww==
X-Received: by 2002:a62:1c13:: with SMTP id c19mr72524742pfc.11.1556662336230;
        Tue, 30 Apr 2019 15:12:16 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id h65sm126756079pfd.108.2019.04.30.15.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:12:14 -0700 (PDT)
Subject: Re: add SPDX tags to all block layer files
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <jbacik@fb.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Fabio Checconi <fabio@gandalf.sssup.it>,
        Nauman Rafique <nauman@google.com>,
        Arianna Avanzini <avanzini.arianna@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190430184243.23436-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <251a6255-bed2-056d-86c8-918de8d6ca24@kernel.dk>
Date:   Tue, 30 Apr 2019 16:12:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430184243.23436-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/19 12:42 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series adds SPDX tags to all block layer files that are still
> missing them.  The last patch adds them to files that didn't have
> any licensing, and I've cced everyone who is mentioned in the
> Copyright notices for these files to make sure no one has any
> disagreement with the fact that that they are per default under
> the kernels GPLv2 license.

Applied, thanks.

-- 
Jens Axboe

