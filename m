Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 012FC6AC75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfGPQG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 12:06:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34819 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGPQG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:06:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so9347564pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u7Jne9Q47nVrWz4TP/HRx+zyw2bqjnPLiRJA58wxBSc=;
        b=j6LlEfPlZaJkswdh3CNoocUKsHhBuzharTmPy44mXWvswWx0VUz0t3ModwJHkAo5ZC
         dGAYrqYLOLEeNs3wmlVg7GguiDrX1hvqg/y14nxQRK+GGCvoG+VzDtZ2hwOs5y2ZgwaO
         rBxu07ZfqHMYAYy9RAWbNdTnOYb5t2Za/6LjhUkA4J/utbO6b6wTRWIYmkeOWI1lDbKF
         tLXIVPHqGyKT6SpjusWHSMMWd2Fkle/H2BkwplrFF3DBk21ngqvwZ3joiBZhys96spbB
         nA79zopXpJx9ow8Cg1H6OZNtKcnoC/nJsaD6z6diVmdVGB35IBs2oivnHBcjRTje3Rft
         eF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u7Jne9Q47nVrWz4TP/HRx+zyw2bqjnPLiRJA58wxBSc=;
        b=mkpOFzsAW3oiQ4+JLIHX1Gfegpj38idc0OUOp3lT8zeGVovCuURSFN/py7wPPE8d4r
         W0gR/a1DoSn9tE/Vi20nr4ckffXReQ3+6OaJ5woOdZCVvE4OKCTDE+BdlcHimr0+6pgl
         szgI/3vStnhetLSVF4rQBaj2vma2/3H6GdOUdlvLK3yeIcrP1xQrRuHDRfdPXm7uLLhM
         ApgWV6eBWNS/YsRng4hAt0rcha2wblNrwl6c1fFLg0qC8h2SqM4CbEKlTAGELnouflFE
         G/5F/m7yBGwh/4FIHznf1T831FtcAmjJLTulZLUOiRaw1+0QDMEckC9Y60MWEri7T7gP
         2kng==
X-Gm-Message-State: APjAAAVRUj3KCbiOravVZE+2ihlFb1PvRh51guUyV88n/+GDHJD62F+t
        +bYSYaaTkVUiB1vTalG42Ei3KB9hkKs=
X-Google-Smtp-Source: APXvYqzZEHBcJBQImE+MN8epzusmvGWxzBljoySzUhUhW3SvZz6HFxvRHP4sC8GOmqWanvyI9qT+TQ==
X-Received: by 2002:a63:d756:: with SMTP id w22mr34233100pgi.156.1563293215324;
        Tue, 16 Jul 2019 09:06:55 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id q13sm20170598pgq.90.2019.07.16.09.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 09:06:54 -0700 (PDT)
Subject: Re: [PATCH block/for-linus] blkcg: allow blkcg_policy->pd_stat() to
 print non-debug info too
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org
References: <20190716145749.GB680549@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f0b11b1-275f-fdc8-51c6-452a727d5885@kernel.dk>
Date:   Tue, 16 Jul 2019 10:06:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716145749.GB680549@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/19 8:58 AM, Tejun Heo wrote:
> Currently, ->pd_stat() is called only when moduleparam
> blkcg_debug_stats is set which prevents it from printing non-debug
> policy-specific statistics.  Let's move debug testing down so that
> ->pd_stat() can print non-debug stat too.  This patch doesn't cause
> any visible behavior change.

Applied, thanks Tejun.

-- 
Jens Axboe

