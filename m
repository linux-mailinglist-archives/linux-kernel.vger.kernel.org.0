Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1565E153AB8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 23:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBEWJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 17:09:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44461 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBEWJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:09:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id d9so1431405plo.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 14:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=BwOR++ZlI6migVRrZllQL8QE2OBgARO29djPlfB1kgE=;
        b=hbQjZrJyGrjjwI9FPYinl8+m5gQisyU9AMnTVhV3q4AIJiN1IRCJflkpWBiOfD0MoK
         3drh9YEc91+HHXaJShaImcpZch6Y0VlXLm2Ea7E7xySAAJvbW1iPHqWQNe6WTHv3hBpE
         60It/p1iY96KFvPF/1gOprmQZkOhqSjorXYOaUR7W5eh2lgeNY5Y5GPdtIITC5neBsIi
         lebr6ME4/wppFvq4zpyrkJN8h53PWmUxNwDepWY6SoWGVfHVy8grlEimmuAnp7QqayE0
         EsLTRWdAl7LivfUGaN/CKkfWG6QNWPrJ6UKccjmjj3CBx1lqatXoPRru9IufCF/fupG1
         Tntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=BwOR++ZlI6migVRrZllQL8QE2OBgARO29djPlfB1kgE=;
        b=BrDJq4xZ1AEz6TV0nQaZmTgxGZdJW9b/I2BDGYdtrFvzI1u5w9DtRPF41/TaoqALE9
         dlb5f+RPDIg420hM1SfGhmOkBbOz1fI52Yz7Sqo9yAanPVCCoeB2e4ruLupmVk1yVnRZ
         ReQpX3K5KlYoFat07ZnUNgH8pyJp7MjaUDEtOjViJKU2sXHp3ycz26d601R4jPlod0+6
         YiwvCpvjgthUvlSjUWUcJmgtCzt7amEG1WToPBNlefpwWRPdNlduRTZekUx7PWlO2UB5
         cKyNjXKI1m2aDECZkBxEfl5pOMpZ9cGlfloUeJzQh0ShZNtkuY6JfPPPqia4eVDlDW/e
         C1Gw==
X-Gm-Message-State: APjAAAUjrBodxBCg6WrXsQyvXuZUzx5sABxp9wcOCdLNe+Z5LVN8VcR/
        OfAh6aAnLfT2TiRE27gdkSGOfw==
X-Google-Smtp-Source: APXvYqyleGHIquua3OENEm1+gLOxATE978T3cJZVn62CI27PBhGzKyFGm8DASmLMaMBSeBFrZw3W+Q==
X-Received: by 2002:a17:90a:8547:: with SMTP id a7mr418620pjw.0.1580940564417;
        Wed, 05 Feb 2020 14:09:24 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id y16sm742663pgf.41.2020.02.05.14.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:09:24 -0800 (PST)
Date:   Wed, 05 Feb 2020 14:09:24 -0800 (PST)
X-Google-Original-Date: Wed, 05 Feb 2020 14:09:22 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: linux-next: Signed-off-by missing for commit in the risc-v tree
CC:     Paul Walmsley <paul@pwsan.com>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
To:     Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20200131071718.248da483@canb.auug.org.au>
References: <20200131071718.248da483@canb.auug.org.au>
Message-ID: <mhng-377e44c9-bdcd-4473-8541-f1c00d249adc@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 12:17:18 PST (-0800), Stephen Rothwell wrote:
> Hi all,
>
> Commit
>
>   4d99abce8ce8 ("riscv: Use flush_icache_mm for flush_icache_user_range")
>
> is missing a Signed-off-by from its author.

Thanks.  This one didn't play nice with git-am, so I needed to manually
reconstruct the patch and I forgot to add the tag.  I've fixed it, the original
thread was
<https://lore.kernel.org/linux-riscv/mhng-19381e7d-faca-4e0d-87e6-29d43d7796e0@palmerdabbelt-glaptop1/T/#t>.

>
> -- 
> Cheers,
> Stephen Rothwell
