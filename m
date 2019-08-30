Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59D4A2C57
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 03:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfH3Bcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 21:32:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfH3Bcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:32:55 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21B012A09B1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 01:32:55 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id i2so4017068pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 18:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XC2aHf7wGh4YyvbrnfKO3wOWnGfvfhL781P+M7KJBG8=;
        b=FXsYkcTozkZP1NdZdKuCzQoaJAIncjkrwAZFm3T/uiYY0I6T0dsi9rDfQjDs07jpM0
         s5bpZzb1bTjuU0L5spqEAM/aK+26tSRKOGuLoUZekrnf9HxM5mRK7V2lnNZFs4ls20nb
         BBd+H/q+voYeLTtnvZMx49ATFro+sjMSiDlcvoKY4XXrbrkdC+ebLhcGtyOz+fRumQ6K
         dGnAIs3onfopuO6vewDFRyKba5gLRalVedeXtSO22Qjxruvf04oC1p0QnWUjgqrichGg
         WBSgrw6VhiibZ40kZeiryc8yHX5++SKrdBSQ6FL7AUvH8H28FE0rnD5X2/9M2athV+gY
         dM5g==
X-Gm-Message-State: APjAAAWRkI/1dNQWiud47RMfm+IoyYI00lMRsHDKq/dOZX7FcfvKmbmx
        tfR3bUwvG1ScwITrnuspnX+T8zK8LtQsfEkih+e/YJsWp0ujM77G8UyFQxh2Ymj0Hgz1vTVHjtE
        VC7JzjVb+vkUt4ZhfNA7eBQ7e
X-Received: by 2002:aa7:84d7:: with SMTP id x23mr15190685pfn.53.1567128774717;
        Thu, 29 Aug 2019 18:32:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz/xUTCyZ30fUpBQgbLlIUWBTsXlz+VM8DCnGq3pXutJN6a6zRJ/ukArdMjaGx5/eHR1wWLXw==
X-Received: by 2002:aa7:84d7:: with SMTP id x23mr15190673pfn.53.1567128774604;
        Thu, 29 Aug 2019 18:32:54 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 67sm5336780pjo.29.2019.08.29.18.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 18:32:53 -0700 (PDT)
Date:   Fri, 30 Aug 2019 09:32:43 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 0/4] KVM: selftests: Introduce VM_MODE_PXXV48_4K
Message-ID: <20190830013243.GL8729@xz-x1>
References: <20190829022117.10191-1-peterx@redhat.com>
 <20190829164638.zu3srhl6i77auyhh@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190829164638.zu3srhl6i77auyhh@kamzik.brq.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 06:46:38PM +0200, Andrew Jones wrote:
> Tested on AArch64. Looks good.

Thanks!

-- 
Peter Xu
