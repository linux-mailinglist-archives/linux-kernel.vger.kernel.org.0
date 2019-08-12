Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C5C8A090
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 16:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfHLOSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 10:18:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40146 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfHLOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:18:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so49561839pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7rrMGWz+cOb7SutGzZqKRd+swOkY9Fr7uDlylm/LIEA=;
        b=Kk64r5VS2ussB1Th19KWQGM0tqg1CvhoXPzjTJeq2UhXZTRgzlKj2xRBylyqZp/Ji4
         XYspgHHlaMvUnCk6Vs+98dbPKx3L06DdBpKGgm5KO3X47SxEg64u8j1tQZSVJPH8TiR5
         akPX2w8NvMur/EGP1HYpH6N3i82x2laj6lSYHtkK4WRMqsOXUmthMfNDrZDzzf7wvB6q
         HtXguBSt7WGu4vKb/MV6ONqSRWNqz5tMgMXBDcj5qJhToi5HpK26fW/upGOc52ncqLfd
         ISP8EcrhIOlLyBQg5Cb6qTVx4NjXMrNwiqstVb8JgfSqbSKNm8EWLv3PUzUmdQLfM2TR
         ExSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7rrMGWz+cOb7SutGzZqKRd+swOkY9Fr7uDlylm/LIEA=;
        b=Z2exfWUFrMNNFfvAkmgET8VQ4aAfLsfWLWt9QFsakSg8XvNZ9wQIB+jXYA1lPV+atu
         XJsILp+o9b52AEpH2T2sGnIiSD+mrsc8p5h81goi5VyeMXrtlwN3LBAFBBamaQr2yUUP
         okw/Vk8yh8fZJ9RJNz60QlfUbdOnZTsZyJ2mM3fG1UZWVEQW71LdnHFFA+sc1xqWOhGR
         ZvJx/hXDQHmWvblGyKH5A22H89W1njL32HLtppqN3C12nb1NTnJvgNNrzSgcyWr6UnEF
         05VsVmMPWLPCyap64qOWaIbxrdZLJNqskrxBSD4G7NlAmR3Z2nqj1yEhDj7JgRSPLfcv
         lSPg==
X-Gm-Message-State: APjAAAX3hBBsJP0oqlJvhSHOxdX6H4wEtxjx+OmblgU4wQADU53X9xoX
        6fjoJw6ilPk0v2sonrDNu8EFRh+jOg9HTw==
X-Google-Smtp-Source: APXvYqzbxyx0fmxJS1Ju4I3T95etCWQ9Tx7GsBM119oZzixfSTVP+n/gCY/etw1wPdiR6UM5OdrXjw==
X-Received: by 2002:aa7:8108:: with SMTP id b8mr16421518pfi.197.1565619531291;
        Mon, 12 Aug 2019 07:18:51 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id o9sm70853775pgv.19.2019.08.12.07.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 07:18:50 -0700 (PDT)
Subject: Re: [PATCH] xen/blkback: fix memory leaks
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        "moderated list:XEN BLOCK SUBSYSTEM" <xen-devel@lists.xenproject.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1565544202-3927-1-git-send-email-wenwen@cs.uga.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0b0bce35-a735-2484-37fa-11d7d3570a1b@kernel.dk>
Date:   Mon, 12 Aug 2019 08:18:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565544202-3927-1-git-send-email-wenwen@cs.uga.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/19 10:23 AM, Wenwen Wang wrote:
> In read_per_ring_refs(), after 'req' and related memory regions are
> allocated, xen_blkif_map() is invoked to map the shared frame, irq, and
> etc. However, if this mapping process fails, no cleanup is performed,
> leading to memory leaks. To fix this issue, invoke the cleanup before
> returning the error.

Applied, thanks.

-- 
Jens Axboe

