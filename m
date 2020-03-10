Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB10D1804F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 18:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCJRhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 13:37:21 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40793 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgCJRhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:37:20 -0400
Received: by mail-il1-f193.google.com with SMTP id g6so12781155ilc.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h0+d0eT8j3D9V9+Zx4d1oKQcV5JrUFhrom1z+SABDyU=;
        b=ZQzkv1fuhdNWzNE9ifob6BaqbjKkH+6SvNYg3ZHUJWbXFc2R8Q8yfRGE79wig81mbI
         0L6uhUFunuYMloqncXL2v1cRg8PwRaoDMUUkmqkskmhVlcccgO/rb/5TFeFn2ieyc5di
         GMfxh6/HBCaccjioU6QPT1B1Oy4FWfObqxttf4IAutbqt70EwJqnnf8T4sP+9JWxW3Qm
         14tIcuh+2zL6Kpe8cY8/zRbLvSbNNgVKmVOvvOaU0sOywOSvdvs5y4xRyveDVIXeQyF3
         YjtjBFeb/ixJD9zhNf+jqdwNwCa/IxhX3QLZchV+Tjwd5ReRp6IFEGUBic/dF9D2wy3w
         008g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h0+d0eT8j3D9V9+Zx4d1oKQcV5JrUFhrom1z+SABDyU=;
        b=svGpr4JA/8EEIu3Rsr/Egvw2xWNgkMBqgvPKrS71XYxgtq2f/uQOdFLXqrUx2Q3nEW
         CIOku/CT7/Idw28gr1mKOkM5ZUNe1Zwz+JQXa2oYPcyobPvEU/jpFUHVZcZ+ReeoIjlP
         aMTd39eqiBPAyYFM1eV3CnNmJwkr9dIslJaINhcgXvQAZiTQpwS5k1/bQbDr1CplMe10
         UA5aE9G2yeVSaExDcWsZwJO8GsGiVtiXsMS7TP5YKjsiv2XeNCYfXKRQ2fnIk9lfn8sW
         KYkKFH5tLbrtlNIdAD6L/+eOBt+sUo6LC3Vgte+GvpI7hiZJGsejLLHWJHIerBmh/rvn
         NTFQ==
X-Gm-Message-State: ANhLgQ18tTiJ13dqkcGZWzXZ3kLcEyoU+lxcTvNgp0psJYjlirAahQR+
        hMOezKySzx38udFYN26the2eKE2RiveSxw==
X-Google-Smtp-Source: ADFU+vu4ZQEDYZQhLz6BySvD3vrhwTsXPiIoQaSW5wd/Cx6rry+V3kDO9EzE5KgAJKOXTnWygYgxBw==
X-Received: by 2002:a92:3d42:: with SMTP id k63mr20711214ila.219.1583861839332;
        Tue, 10 Mar 2020 10:37:19 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s82sm2523530ili.87.2020.03.10.10.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 10:37:18 -0700 (PDT)
Subject: Re: [PATCH block/for-5.6-fixes] blk-iocost: fix incorrect vtime
 comparison in iocg_is_idle()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200310170746.GD79873@mtj.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3980b91-7a43-2493-48d0-081ef4158d2e@kernel.dk>
Date:   Tue, 10 Mar 2020 11:37:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310170746.GD79873@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/20 11:07 AM, Tejun Heo wrote:
> vtimes may wrap and time_before/after64() should be used to determine
> whether a given vtime is before or after another. iocg_is_idle() was
> incorrectly using plain "<" comparison do determine whether done_vtime
> is before vtime. Here, the only thing we're interested in is whether
> done_vtime matches vtime which indicates that there's nothing in
> flight. Let's test for inequality instead.

Applied, thanks.

-- 
Jens Axboe

