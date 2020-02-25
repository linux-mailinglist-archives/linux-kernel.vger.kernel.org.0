Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3262D16EBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 17:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgBYQny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 11:43:54 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35158 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbgBYQny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:43:54 -0500
Received: by mail-il1-f195.google.com with SMTP id g126so62954ilh.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 08:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ptuBikuvx1n72b69f5GFtZDCaDnREx2JRheiA6ifZ/E=;
        b=Es0Ai5yjDOXrynnmjpTZm0+Anp7kBXgBGQIVFpzx37hZepTbICkrUSYrkPuYBz6rbG
         UHSy7Ksm8jQU2QzexYbRyPAtMSPheLGmVn8lruBifATHnpmsHwPGUM9fQiv5lRMrknUl
         WiwrgrUkMSOZkD5iNTEZ8A+4vkEKdKdUSaVpzCYs/caEFIuzxSBfwnvh+IMF72dhdleU
         8RiVnjvxWx5WK0yD4WSfzzLbLLLVuDC0YGvkl/H31DlBD0IXMjXYRO/u7aR1nCCwlTH1
         foKxJEluiuSl7WqTSEhDzy/MsodVN8MoMnp7BV2sTxcCj36767ht94/FbLiCRAATqQqA
         28iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ptuBikuvx1n72b69f5GFtZDCaDnREx2JRheiA6ifZ/E=;
        b=ly3WwXYNUDIV3m5ihznuglRn184vmftg+qhGZ9XQXaAX9Yy8XOIc8JtRMpqG+OtvCX
         z6uCbIqD9kl5wsYa0KdXTjZb8hvW5RN/o9miEvup90gjqBPisV9AErFlxa3x3qH27ZxJ
         n5qt71AOtZTA5Isbnwr+u2LtuLgxsJ00+Nv8gogRTmgTF4ijYi/2gSq2yzQOHB6ypTka
         j4zkW8mtw3OCHPwxOC6S5+nLaqCKO724g2Oy0jtRsvMG9uRzllkKFVvOije55hwZkt+n
         /VwiYpPXxP9FzmS4uUJurJSLgINU+EiAyK5Clh5pOMbr7SB56qaJfK/UbwLO0TKmClpC
         z7MA==
X-Gm-Message-State: APjAAAVbMiJr1P047WPdCosoN8Q05kFWpsa4Buw9h2wF/tD5SpFFDl+o
        cpwJO9Ycq2x5ErpvsRnrOFG3edr9tUE=
X-Google-Smtp-Source: APXvYqxBKxRpHZ4VWxYc/SOhkA9+f1ToPdotu/ruZ4hbpJVvIQrAiXadwkKdiQKUnnEAKvTxmzC5eg==
X-Received: by 2002:a92:405a:: with SMTP id n87mr67309416ila.299.1582649032564;
        Tue, 25 Feb 2020 08:43:52 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z8sm5632654ilk.9.2020.02.25.08.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 08:43:52 -0800 (PST)
Subject: Re: [PATCH v2 1/1] null_blk: remove unused fields in 'nullb_cmd'
To:     Dongli Zhang <dongli.zhang@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200224183911.22403-1-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad83d8c0-4d3d-6cec-3e5a-70be9505c15b@kernel.dk>
Date:   Tue, 25 Feb 2020 09:43:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224183911.22403-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/20 11:39 AM, Dongli Zhang wrote:
> 'list', 'll_list' and 'csd' are no longer used.
> 
> The 'list' is not used since it was introduced by commit f2298c0403b0
> ("null_blk: multi queue aware block test driver").
> 
> The 'll_list' is no longer used since commit 3c395a969acc ("null_blk: set a
> separate timer for each command").
> 
> The 'csd' is no longer used since commit ce2c350b2cfe ("null_blk: use
> blk_complete_request and blk_mq_complete_request").

Applied, thanks.

-- 
Jens Axboe

