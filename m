Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF1B62676
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 18:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfGHQhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 12:37:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43388 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGHQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:37:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so13765730qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d77j269b8ii4jGD4hk2Ust+/CV3shrzBdzDbm/56554=;
        b=uYCSLFLo5IWrRj9BTn09XZfD5mBsOBwhtDYOHefm16fOEt9+8bUk3UTtmHF2I5Ujlm
         CA4sFrts+vEyrL0L7u7u7nP7lrP0F6+L1hn6v6V4jepzWMgJDi4zhowOQOvnwNqC0Fs6
         iVHx9LjyEvX6DNm1ZJKBwhRLJ6KCFa8U5PyVqOPMJyxKxCYUshYLiCfFQqVj6p4vvw2o
         F4i7nr/glAa1/zAzP/ZuB+enz3ixQ56845Z7vsY77ziD9hFk1qLCJILZTxt2dN75FCig
         oH6HnTje0x4pfjDxOZokrIs4UI7dy549syh5xokqYnCAwjYtGwh9fsNK++ababrCILWD
         mB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=d77j269b8ii4jGD4hk2Ust+/CV3shrzBdzDbm/56554=;
        b=lf7km//Yycd4nCx72Qt+bsrHGa3oWIw6yd59hbwjBx9e2PC/mJIZIkDYeXxN6arK8b
         MTCbWkYghH9C4FZ9/arxiRjT+78ZUcBsA0ngWzMyTaRPdhnd7FgYD+Lz+pSrnGxenhrI
         1tjX+LtwvHinxg//EHJVd+18bn6rnKAJ4G10X2kYpmSFzcDSzlTc57JlJswQ1tjrHuEg
         mQ6nVPuSL1RSh+Mv3/hKVL65+0JykXR5G6ekWEmx+AYMUqmBR+s5L6Mp6uRhQvRKSZpR
         MV+QCYxnKGCx3H57tdGyLx/NbPcv6xsvr+3m2qMiUuCCQInydsN92jbFU4k2vu1Ee444
         ED3g==
X-Gm-Message-State: APjAAAVXxB9zaW4RNKchn7P3sBfcOVAYx+kOrvvN6Bk3YiIL2Ew0b2Ao
        8s+knuFKmMcAfFZAC5heX3A=
X-Google-Smtp-Source: APXvYqyg6ZU38Ki/RRPgH24okSlx6akBtZnsqHskOvYhkaNo+9/Cad7dv/wCSe6v2WEcze0uXlCjbw==
X-Received: by 2002:a37:f516:: with SMTP id l22mr13870793qkk.123.1562603851050;
        Mon, 08 Jul 2019 09:37:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id p59sm2249911qtd.75.2019.07.08.09.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 09:37:29 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:37:28 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Peng Wang <rocking@whu.edu.cn>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernfs: fix potential null pointer dereference
Message-ID: <20190708163728.GC657710@devbig004.ftw2.facebook.com>
References: <20190708151611.13242-1-rocking@whu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708151611.13242-1-rocking@whu.edu.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 11:16:11PM +0800, Peng Wang wrote:
> Get root safely after kn is ensureed to be not null.
> 
> Signed-off-by: Peng Wang <rocking@whu.edu.cn>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
