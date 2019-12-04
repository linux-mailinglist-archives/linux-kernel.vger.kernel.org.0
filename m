Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 197571120F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 02:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfLDBQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 20:16:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42379 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLDBQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:16:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id l22so2730403pff.9;
        Tue, 03 Dec 2019 17:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kVMURLAlBf3/Fz+kLTObO2tSWfvuZ8y3HS/6yJNgqJk=;
        b=TVIdDW4wlBo5WAqSMEcGSakx0SFJZt4Et+cnEAQYghLWB0EO7HFhoQlq9nMNfvABVT
         9FI6EGtFZbLjHjR9tx7/6LYOxN8m4ftAwuK4w0RWF2whJeUMrvIa8lYbQU4nvdUNmhsU
         fL88RqL30QlD6/ilsP7iTC97WMXe7ZyqxhLvd6LLfi/h4AWgnownhDhOOfUUeVWeAclS
         NtchQhkX3ALtV0/+ogOAqbDShJ24db/V9OZq+WLukIMb+Uj8P5pHLXNiig819952qRPJ
         OuYaAkYP4MYbZcQoLpNtuW3bFUxY1tYwAET6j3f4DE+ISQ5LHn0yky40VGx8XkZsoQem
         3n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kVMURLAlBf3/Fz+kLTObO2tSWfvuZ8y3HS/6yJNgqJk=;
        b=uOtMsDnenAutM7APyeTbsm35VAUXU4aa1f7RgbTbEDPEoezsnGngjXz8ssES3dq1v7
         yCrplGyjsl0Pj1oUf0kSPXzdymLPYS48z3SVdlqXh9nMJewlEfBSaIri+n0q/fqvc6jj
         15s8CYBvqu7kBmPfYj6vmLorWYw98btiqH6uexRUS6b4swohNK4KYJxBFMsAWUS4ZYZB
         OhswUiCzbdApVbkyXEWfxShq9o3Vdb3K6nXt9eRzuqZcomDOCPGKuu6OYC/7Z+YA6uqR
         k65PXinzilRGLL5QPyGOibJy759jHodmWWhULJRFWLvXOhKyukjAN+4+zSPrEh7DGeb2
         78vw==
X-Gm-Message-State: APjAAAURH+ddz1HD7LWNQrWUbjI5OaDhmPP65vFM0jzZSwLgMmUYN3eI
        ewhXaKdp/41pSXGMpnRHmsw=
X-Google-Smtp-Source: APXvYqxK210s2BvoZGUjQ6XAf1PmqV0N2sOB9dy18+b/ZWXEhdBFM64fbqfki8SvD1ugC0TEqgdfaA==
X-Received: by 2002:a63:184c:: with SMTP id 12mr707314pgy.418.1575422191607;
        Tue, 03 Dec 2019 17:16:31 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id k15sm5545370pfg.37.2019.12.03.17.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 17:16:30 -0800 (PST)
Date:   Tue, 3 Dec 2019 17:16:28 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: fix error return codes not being returned in
 writeback_store
Message-ID: <20191204011628.GA6629@google.com>
References: <20191128122958.178290-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128122958.178290-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 12:29:58PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when an error code -EIO or -ENOSPC in the for-loop of
> writeback_store the error code is being overwritten by a ret = len
> assignment at the end of the function and the error codes are being
> lost.  Fix this by assigning ret = len at the start of the function
> and remove the assignment from the end, hence allowing ret to be
> preserved when error codes are assigned to it.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: a939888ec38b ("zram: support idle/huge page writeback")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks!
