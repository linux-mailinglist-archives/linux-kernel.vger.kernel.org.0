Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9823438BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbfFMPIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:08:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40650 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732381AbfFMOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:00:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id c70so12762321qkg.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GwTb9BI2f5ybKBNoF1NplcvQUpBaKVKJxwsFqjlRC1A=;
        b=ijpb3i/2Lb+VobYX2DK9Gl2bviNpKkUKEJmTYoNVT8mhCwXaoODROQGCBSOhVMaNEk
         q5kzmBF6PtK2inMDmzDMdFC2OqoKSLwbUJAXpEpNnnAtGbTKNarVK30V8dAcZvyaMevm
         gLIwk058H9uouJGumsKfKwm5/ULAUJI+rnS4wMisCkm2lEOszCJ1EMwEYHedggQ4yOLW
         arYoaw5eiROsQdWwF27px52osQKJNcaqUKsjuAYKRw0+yYqVC6cHpr1Ftei9BKDQsBUd
         0R06Oa8c7s7RFdIbOpsBdaCEAOtFRvkWuBuzs90afQ6tsy81SVHNqpTVHa3MOgTOMJFj
         pfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwTb9BI2f5ybKBNoF1NplcvQUpBaKVKJxwsFqjlRC1A=;
        b=QZBXk9emSgORwUje8e92euYwAGZjh0s39vu2tkaWDKo9ZO5fI96ZkgzOxg7mxSGDCO
         9ITB291rL4X8EuRY0J8eynA9PhhcCAP4hSgXgg4IVq4HPcNzTTNwrN8qIFDgGA9vfoxK
         kPbNiBie2Y5sZ7Rof/HcdgJl3M7A2X4dy4zx7EuDoo8pwhuMzyM0zgu9CQwFxu080GQq
         oDINUY+zTkVmhbwihYoUbRFkMBhtrbB5TmU8O5djItUNBTAbyJNJySA5HIvp0Mxuvsgn
         vKFwPF1hbDsrjpTAhy5DklBslx75uEPTjgEXYtjKRCgH/PpNkLn7HEpNFpQ/58H5iTa3
         ff7g==
X-Gm-Message-State: APjAAAWqYuoGH+w2EFcJLSH0FV7xrJahZpME1J/nvuClTuz5gVCNRs5u
        7xPyPWPOigx5WHBezeWsV/7wXg==
X-Google-Smtp-Source: APXvYqxh8vCM/pvzEH4tnahtRLzbEwsZyMCxbmxFAiZcArhDBtt/gl6tbxYPxtNzTPzgkdMswgkPIQ==
X-Received: by 2002:ae9:e504:: with SMTP id w4mr52029967qkf.296.1560434423873;
        Thu, 13 Jun 2019 07:00:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id z21sm167500qto.48.2019.06.13.07.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:00:23 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:00:21 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 05/19] btrfs: disable direct IO in HMZONED mode
Message-ID: <20190613140020.iiqzrkdztindfjyh@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-6-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-6-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:11PM +0900, Naohiro Aota wrote:
> Direct write I/Os can be directed at existing extents that have already
> been written. Such write requests are prohibited on host-managed zoned
> block devices. So disable direct IO support for a volume with HMZONED mode
> enabled.
> 

That's only if we're nocow, so seems like you only need to disable DIO into
nocow regions with hmzoned?  Thanks,

Josef
