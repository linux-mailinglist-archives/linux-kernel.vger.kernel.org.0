Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642C414F4B0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgAaWYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 17:24:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35891 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgAaWYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:24:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so4085361pfv.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 14:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oNPDXr5T2F3ltBr6ZWUFkUTRD5GIjwn23cg1EDJm7Qc=;
        b=he0YCpvPIXitkS2gkBPL7SoeIrDKJ6TyukF76x/Odh2lowB7nunGusPhq/d4ccAJKo
         w9snSRWXHEqoPw0uC4UfmOa/YxRkzBM4y0IncMjvWnm8BTlSvbpz0kIOJTF5NBwvzt1I
         GFarbrT5hGOVCKGgTj+B64Zxc3ObuJR5Wxvlf4nXLAuH/stizMkhu9XxTr0NMywPpGXa
         FgMjJjW0oai/+kJeUc99yV5YVuA3PGQX61Hj3YLkNCkqfzheOYSA052mK5tcZsh9iHQR
         n+wzROfVBw1/+JU/QpCXDwSiqH3LfEKAIZrcEkTP3flw7WJ6c6HCJRYTIlO/htosbNVJ
         jnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oNPDXr5T2F3ltBr6ZWUFkUTRD5GIjwn23cg1EDJm7Qc=;
        b=lxf+KaigjR1dET3rJCq1xD44O/R3JqF8UfAb2E58n1ZnQ4pPdLkXX813KQPWXTcHMT
         6cm0X7dw0y+9Ms7jSsdX2gv8r7wsTrXldC24/RJFK7tlN3Vds2YmwYDMQ/hzyshDvk+c
         VzJc7/E018NMLiLkWRWkkIsr5llxyY4RPlryiqzLFIVR2YBN3R2h0cofpO6vPy+XgIjX
         MtvJazQv+IpJuXAfX14j6THPp0MgkEw0GXTd0lrPQIL+LBo+FE/T3wJmXHrOXE52G6/m
         I0sNM0KtX4UwVj5BIAJI+Y8DbZ45eWcEQgZL7qMx+EHQw3msG1tr/LTIrD9HppHB95Lq
         zaOQ==
X-Gm-Message-State: APjAAAViNsZb9oWfu7yValhHlbbcEn6mCRShUNP9vczOG91/6QcaDHlj
        5DdqKUs+p1Syq6NDRWW+nw9c9zwdpVQ=
X-Google-Smtp-Source: APXvYqzqKO/A1Xn8xjFjOlUoV7dczVeMJ+fz7E71+uwn7PFxZK4KZm22X7LcGl3v3xEtRmZxo51WHA==
X-Received: by 2002:a63:2309:: with SMTP id j9mr2382056pgj.54.1580509447440;
        Fri, 31 Jan 2020 14:24:07 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id j7sm966255pji.7.2020.01.31.14.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 14:24:06 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: remove extra ->file check
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <e21d4c192e0fb12af00cbb4c1ed7d517385ec160.1580509300.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <649d912f-704b-d362-2bc7-1217840de672@kernel.dk>
Date:   Fri, 31 Jan 2020 15:24:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e21d4c192e0fb12af00cbb4c1ed7d517385ec160.1580509300.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/20 3:22 PM, Pavel Begunkov wrote:
> It won't ever get into io_prep_rw() when req->file haven't been set in
> io_req_set_file(), hence remove the check.

Applied for 5.6, thanks.

-- 
Jens Axboe

