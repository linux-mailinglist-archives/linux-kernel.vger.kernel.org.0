Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735B7883BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 22:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfHIUQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 16:16:57 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:49852 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfHIUQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:16:56 -0400
Received: by mail-pl1-f201.google.com with SMTP id b30so4249969pla.16
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ps+kwDWgQoJY3CUqmmTxPvXo4adLKJif88scg6lrYf8=;
        b=fv2YO58sdU4AQ4I/RtKsVvbmSmj2rwepYD+glEMaxde9cOm6Ya1Ge8Yqqh3kUojLFR
         JR9B6TmnOS9/7Cby5qjnT7Jwt+MSb5MBzoEadrZflPdmFu4/4wUorIzus/YVb/0vW54b
         7BM8Ma7BcDggHUci6UxcpH6E3/K/FaVHCspRanUX+/U6xeYXGoAU/Y5yL4mA76W2t+Vt
         U+pv5sBr0JvQPF2XU5wobvmIToBPSRKm0/7tbvw9m/SLl9CB9qlnKfcBs6XBzNLns0+E
         xhzTcCdRsNKolC/cIfwsLdeQyrCtbWSTPecL+kc83QZ+Tc040PLhv9PgsNjp5E6kMhgw
         xYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ps+kwDWgQoJY3CUqmmTxPvXo4adLKJif88scg6lrYf8=;
        b=hXEDyEvkjycBe+UlWa3fjk0DsY7W9/DNZ+8WggrOxvh5Qc5iy7ha/rq0kr4aPEciSQ
         rVUqP4Vkg3waWztM3GPsMn5sj6KD7f5V9DNP5oxfT+Dbw6U94bTf9ea0+j0wjuqx81M7
         aO6RdaEuneWogZRzLnBCzazwUrnVlPomMmMZoyTdQm0AkH1Zbwe+Rb0eSAnjzS+8ecyH
         xN9kGYyA2e09wEy2d1wKBMiVEReJOAvqoNfFjrvwBvfV+T+gbl6rtG7oqByu/tzpCe4M
         s39UnRk/3zb2MNwbjx5K4tP8YH4FwMNLIM/dpsanTYurwgV9jVaOIguKM9b4kkmFMH9Q
         +Jkw==
X-Gm-Message-State: APjAAAWURQnwYxZuKWWPENSKFN6E86zS/ua6eJwnn+jVDS0Zk9Ir5tdJ
        jH/XGw24SEodoMlEzn552kGaBa1fOw==
X-Google-Smtp-Source: APXvYqx4tBQFTVP3rt8jWo6e+xDOIHSc4BJlYb3KbGQ87YLO7T3+MR/DvWzL1C/XLAPt3HRHlZUVWLQzMIM=
X-Received: by 2002:a63:29c4:: with SMTP id p187mr19362879pgp.330.1565381815497;
 Fri, 09 Aug 2019 13:16:55 -0700 (PDT)
Date:   Fri,  9 Aug 2019 13:16:31 -0700
In-Reply-To: <84df6071-ef7e-c3d6-6ffa-fcfcbab0c8e6@arm.com>
Message-Id: <20190809201631.208455-1-yabinc@google.com>
Mime-Version: 1.0
References: <84df6071-ef7e-c3d6-6ffa-fcfcbab0c8e6@arm.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: Re: [PATCH] coresight: tmc-etr: Remove perf_data check.
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I totally agree that checking etr_buf is a better way.
It solves my problem.
I will upload a new patch soon.
