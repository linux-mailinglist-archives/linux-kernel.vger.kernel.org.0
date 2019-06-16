Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A3F475EB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 18:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfFPQ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 12:28:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40075 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfFPQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:28:48 -0400
Received: by mail-io1-f66.google.com with SMTP id n5so16117216ioc.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kPiA/oNevUhRBO2JdZUhAfMEefI5MSXkfAyyA+qjAoI=;
        b=ZuJZpMgO67IwPKsk2zIQ3u0fDMQwPi6Dm3LJ/tQQ1GjZHSQ+fm9MYmTUtkop4hWd40
         bowx8Z65wKahMVuut/YVjhml3DIHgV0bZ+D/Vptv4qOo638HWV8JUOo2RrVaRX/o/JKs
         P/fT7gSExAvZq/tKZeLhjSOM7Jj0v0HAaEE1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kPiA/oNevUhRBO2JdZUhAfMEefI5MSXkfAyyA+qjAoI=;
        b=CIuCW4B6Qh4fn8vVp3BWraVs0xgiMhl8Laqrv5CfSVELSC5aaUN7Lk1SF7YvFS6jmc
         voyLz9UGkQrIwnPbdk5oQQ/QYmo/PnL9ZP/8I+3itAuvB//FpizqFOWHdpdqnQo0e7Gi
         626HFBCXZNZnahf/fYxKWELrltTG8EAWBX4OgOhAAqCBEEmZblYYJOIG+OGZ1TGWUhKb
         VU3h3uDtGqWjQfo335rIG6xAfVFjwCmCLInjAzGlV2offCI6G2ZhaBWujFmW7w6GIfHZ
         WW61tL/4+20pLtIQr4zB3qDVGS7ESpRb4jpAzsQk0HF+9cQD9DBnPKvoQCTByNMHm05W
         1oiw==
X-Gm-Message-State: APjAAAXgZvN73EoJtShyVpueC4dB0/efz+8WxnZPIz1s/j02rlT3cwy8
        Bm6G5mZUGsABSPzLci0Gow6vzocPIU8=
X-Google-Smtp-Source: APXvYqx+8CFBEYxM5adb3VSV6dHq2dQxi5ArTkKBj6dzLbsQSj8qB8+9/QB/W40Jdrulu34CoCHByQ==
X-Received: by 2002:a02:ca57:: with SMTP id i23mr24432449jal.25.1560702527373;
        Sun, 16 Jun 2019 09:28:47 -0700 (PDT)
Received: from [10.10.2.64] (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id y17sm8950377ioa.40.2019.06.16.09.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 09:28:46 -0700 (PDT)
From:   Steve Magnani <steve.magnani@digidescorp.com>
Subject: Re: [PATCH 1/1] udf: Fix incorrect final NOT_ALLOCATED (hole) extent
 length
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
References: <20190604123158.12741-1-steve@digidescorp.com>
 <20190604123158.12741-2-steve@digidescorp.com>
Message-ID: <a6275c24-7625-d532-0842-f8b16fea5b30@digidescorp.com>
Date:   Sun, 16 Jun 2019 11:28:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604123158.12741-2-steve@digidescorp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 6/4/19 7:31 AM, Steve Magnani wrote:

> In some cases, using the 'truncate' command to extend a UDF file results
> in a mismatch between the length of the file's extents (specifically, due
> to incorrect length of the final NOT_ALLOCATED extent) and the information
> (file) length. The discrepancy can prevent other operating systems
> (i.e., Windows 10) from opening the file.
>
> Two particular errors have been observed when extending a file:
>
> 1. The final extent is larger than it should be, having been rounded up
>     to a multiple of the block size.
>
> B. The final extent is shorter than it should be, due to not having
>     been updated when the file's information length was increased.

Wondering if you've seen this, or if something got lost in a spam folder.

Regards,

------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

