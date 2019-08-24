Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF339B9AC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 02:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfHXAaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 20:30:09 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52873 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfHXAaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:30:08 -0400
Received: by mail-pf1-f201.google.com with SMTP id a20so7621894pfn.19
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zkT1VJzOlMpr+PFhdjulVHmUztYGPpsUcL1mcrD/sx4=;
        b=XV0kIGfNLhFKDErAKV4H4RtNR00mLJJVXSCIWoEkw/0J2J6foBPWW7JP1DLkyJdJ4L
         kslBmPi0XhLhRoam2pwpXrta1dWTQ7E0fdwmqbqss+eWXhDlJPc3Fi4LlIXSZiFo/bst
         qPTbxxIAp5g0EF/0rDGLgJ3drfj00RbQvupJYLutusnyop98Z5bl9AUmCy/5uLG7jnrT
         WEhaEh5HdYmQzG6Jh4R7QXoWAfRasZfFn5EH3kbWZIwMNJW/EQKSQLWN9b0s1J0EiRLj
         7mnEAq9of1Of2/H+G93xViCMwhHYB5b7V3wPJh49LbTX4J50fGbjmj0sp2XiR6RWkcSg
         086w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zkT1VJzOlMpr+PFhdjulVHmUztYGPpsUcL1mcrD/sx4=;
        b=iSSF021w7ifrjPyE5T1PR9nu3bjnv/3XWSMVyuSuv53KSY5QCF8/9RLJwf0xvXZeF/
         PMewxX7bFaoDZgcMK9CKtwBZrQk/4h4h4oiUMTm4vGu7HTPDHfl/uuXE9n8KQFsK8tuK
         7epWMP/3cYuQxad6GUPfodOgwosUipE7GSE+d8cj+77Z2Aa7eTNGFggteWbQGGI7L/jl
         3ehnB8NenxhFlUg3H3kzssZ2xyWEEtmzn6xoaHyFgNd54PF+MFD3aUoqEAbsm/L3Fqbp
         nqEoiyQBuNMzoUySsmHGKtemJj4SqRRp6wI9xo3VA2TYMWrYWtrgGCUJ5OUaqdf6hAm4
         2jcw==
X-Gm-Message-State: APjAAAWHV/rfQQnXpm3R+ELacKAHpBr8PbLSPp8akmKRF7mAOkHWN8f6
        +LvhKcZKSrkeV8o2IAuKBMh1MSznHA==
X-Google-Smtp-Source: APXvYqyEOPLUtDizG8AcfA+fSIo2U88KPAd6cNLP0knFvcFoo7pvjTbOpThlzzU6BqduUVHTOxPE851nWlw=
X-Received: by 2002:a65:65c5:: with SMTP id y5mr6171809pgv.342.1566606606983;
 Fri, 23 Aug 2019 17:30:06 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:30:02 -0700
In-Reply-To: <20190822220915.8876-1-mathieu.poirier@linaro.org>
Message-Id: <20190824003002.87657-1-yabinc@google.com>
Mime-Version: 1.0
References: <20190822220915.8876-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: Re: [PATCH 0/2] coresight: Add barrier packet when moving offset forward
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>, leo.yan@linaro.org
Cc:     mike.leach@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for fixing this problem. I didn't realize it because I usually use a
buffer size >= the default ETR buffer size, which is harder to reproduce the
problem.
The patches LGTM, maybe you also want to fix the problem commented by Leo Yan.
I tested the patches by recording etm data with a buffer size smaller than the
default ETR buffer size. Then I saw barrier packets when decoding with OpenCSD.
And I could decode successfully without error message.
