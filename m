Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7944147141
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 19:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAWS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 13:59:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40085 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:59:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id s21so1728464plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hAqWpJ1NuJTGK5OF4DpdL8tVTeFlEZehO0INBb+L18s=;
        b=M9Vgqe1fI4i1vkrxFL94iqUTtEMBkNNpQs1Jzc7292AqRfj9q/5vvSUaw2jVl5Ghyz
         tTJrd0Ilejp/eyhwIfFLkzi5V2FBdZgW5PMuUSJ8jSuzgZ1TeO0yenU8WQJqhe3+mKHz
         t0XknWPJgsX/ni67qERPzuVT0b7IABVBticzPrv/0X2ZrdPrD3gFfRWrXCuFjlHjjg6F
         URB+1y9Q4a+zaR+1DX9f0oM3BMINDMhZFuN2+WT3zurC4b3cYpvkz2SdXueZNvTulPTf
         ZN4uwHr3mbX3gAfsFyjfFnK5bDIiPmAEKlcSdpXVCfw6Qrts/CICt4bYicizXTmrFKch
         O6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hAqWpJ1NuJTGK5OF4DpdL8tVTeFlEZehO0INBb+L18s=;
        b=FmVc8mwJ9YEkgGycr3WonrTp/3+lM3gSpoXFZWhLD6xpokezKnO/M2GTfJvlNQdCF1
         zBU4F0NTRUoTfeZcySzylAiwK14RgIfbLG9FdS5BxjnKC+TVD+wF4gNzGDxsWQ3GMnnv
         sZ92IMry6WTxzr3xeWAXGOGh+Rn3FaW9NvYjlNi9yYk3MTFBxRfy4sqFKXB9CW335zTG
         5QtjoESzfyP1fQpVBNru7EG/Ncsk7GeWeSedvAVdEy+ZCNAQkNDinX/ikArkPOIIBt4F
         Xcg8GedzJIbv/W4zD4nnn3DD3Ij6SD2Ys5rLaxVq84TTEsVq2j50HB41pdIzlhBrnr+p
         hVjg==
X-Gm-Message-State: APjAAAUSX7JFgatE5dmo4N5glwzaQu9bPg3t8Tq447IjxzI+cMhWBn6q
        WL78qfJipoStwyxY6TuY2OzfNQSyOpBIfw==
X-Google-Smtp-Source: APXvYqyz2oXSsDtYYv3RSa6VA5HhqPv2N44KU2lqJNVnXf6/2pcJ37hmJrAs7TseU0myONmwtXsu/Q==
X-Received: by 2002:a17:902:59cd:: with SMTP id d13mr17953917plj.146.1579805952557;
        Thu, 23 Jan 2020 10:59:12 -0800 (PST)
Received: from ?IPv6:2600:380:4562:fb25:b980:6664:b71f:35b5? ([2600:380:4562:fb25:b980:6664:b71f:35b5])
        by smtp.gmail.com with ESMTPSA id v4sm4123577pgo.63.2020.01.23.10.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:59:12 -0800 (PST)
Subject: Re: [PATCH] Adding multiple workers to the loop device.
To:     "muraliraja.muniraju" <muraliraja.muniraju@rubrik.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200121192540.51642-1-muraliraja.muniraju@rubrik.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <88d16046-f9aa-d5e8-1b1c-7c3ff9516290@kernel.dk>
Date:   Thu, 23 Jan 2020 11:59:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121192540.51642-1-muraliraja.muniraju@rubrik.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 12:25 PM, muraliraja.muniraju wrote:
> Current loop device implementation has a single kthread worker and
> drains one request at a time to completion. If the underneath device is
> slow then this reduces the concurrency significantly. To help in these
> cases, adding multiple loop workers increases the concurrency. Also to
> retain the old behaviour the default number of loop workers is 1 and can
> be tuned via the ioctl.

Have you considered using blk-mq for this? Right now loop just does
some basic checks and then queues for a thread. If you bump nr_hw_queues
up (provide a parameter for that) and set BLK_MQ_F_BLOCKING in the
tag flags, then that might be a more viable approach for handling this.

-- 
Jens Axboe

