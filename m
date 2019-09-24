Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CECBCA27
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390391AbfIXOZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 10:25:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55071 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389030AbfIXOZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:25:32 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <connor.kuehl@canonical.com>)
        id 1iClkw-0001nj-QK
        for linux-kernel@vger.kernel.org; Tue, 24 Sep 2019 14:25:30 +0000
Received: by mail-pf1-f198.google.com with SMTP id z4so1615924pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 07:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d2M7WLJ3K74mxo9MIAH0NR1Us3L8/cH8DqjuitiaoO0=;
        b=hBNKLgeOtmOOmzTVoMz4EpdnpI5pLZ1uT6VmrPdeRHYs56J1rBtuxxcg6R9TN8rLZj
         ZSuQZwvHapABiwrIYGm49iJ+LbfaB0fDIxZ8Yd2LMuvxuwo1qjcI/5mfCIHJ6q+KP7LX
         OT0RJI+tGYU79IPz1eU4woDRt2ZiP2GJ7JNG1Nmvk2vd/45RUkry9Ne/fUueIIfYlz0B
         bti0fUoyyKMru5ATllzCt1eZX2gF59PagFHygxwicvQwWZO7OJZvFjlv43C4YGB6/3Y1
         0ytBOfuf5qa2i8Z9age+mkZAF3jZH/g+qQvV7BS1QYudoAGbqs0CIV4EV/GrL7ptjv9A
         sVCQ==
X-Gm-Message-State: APjAAAUYFB/5gRisyQHWPDJacx1FyQ/HQ3bsafw3taKm8r9qqEturZK1
        T8K4ktcSwgoDc/I8gkjlZg27hWMFop+Rt6BEg+MPRgrlc/O9RpNBS6074AlLqT/H5FeC8E1Smz6
        C7Te1h4J1wYr+1T0NA3fH224+GX19Iz74Cq3WccYR3Q==
X-Received: by 2002:a63:a051:: with SMTP id u17mr3356954pgn.7.1569335129531;
        Tue, 24 Sep 2019 07:25:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBnSY55GzZ2RMXUXmrcReDI1y3kPMa6mqQgjlGQHKADDop+hVWXf6WJYYfPT50sFT/Uq43rQ==
X-Received: by 2002:a63:a051:: with SMTP id u17mr3356931pgn.7.1569335129308;
        Tue, 24 Sep 2019 07:25:29 -0700 (PDT)
Received: from [192.168.0.179] (c-71-63-131-226.hsd1.or.comcast.net. [71.63.131.226])
        by smtp.gmail.com with ESMTPSA id f188sm2037899pfa.170.2019.09.24.07.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 07:25:28 -0700 (PDT)
Subject: NACK: [PATCH] staging: rtl8188eu: remove dead code in do-while
 conditional step
From:   Connor Kuehl <connor.kuehl@canonical.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190923194806.25347-1-connor.kuehl@canonical.com>
Message-ID: <52e473f0-6b92-9504-b86e-a73a0d82617f@canonical.com>
Date:   Tue, 24 Sep 2019 07:25:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923194806.25347-1-connor.kuehl@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sending a V2 with the loop removed.

Thanks,

Connor
