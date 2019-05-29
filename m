Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B12342E504
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 21:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfE2TIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 15:08:51 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:35948 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2TIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 15:08:51 -0400
Received: by mail-oi1-f169.google.com with SMTP id y124so3005203oiy.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9M83j5VgZqnbq4QKIC40z5RykjHLdbDcFYqEBFQAM9Q=;
        b=BgnltxIEsPclx/Vr/vTO+Gsl82dS1ePz6T2lP33ZTGsNESYjGtxIeObAnRKRmFAxOA
         Y74UbJTVWozTlkVex8yk1ziJ9mntkDto672j/G+Jtq1KcPlxdkM8kwH0tqXPesKj1dpF
         YxZobEBmWukUm2HLt5X+VxhllyQnhcBY9RLLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9M83j5VgZqnbq4QKIC40z5RykjHLdbDcFYqEBFQAM9Q=;
        b=PCstp8V/z65hLQEC0DZunSlVYhdIiBGlx6bzoGkGnDFDx65RV81L55/EvYXcQVhARE
         ISCLgvLk8mlAcYEpaficNiSq6Tq7xjQzR7fOD33PxCiDg32xRDd5zIX59sEug2No/Lhn
         Zwk7L84vcBTP7D0t3wQmT1iN8rKUK4GpI4ctxFsvASwp5WWNGkSw5yKTwySMtPoH29jo
         VA4fTfxTIVlOFj8hN0BkbR5AeaZYT8z0Ra6KdxQMGaiJsySNpmzAs/SLCvGJUQ3jRR6Q
         p2Nlcnkm7BYobgX/QLtVP4xDBTzHZYVogeRiZLn1PfKHNsqhXXwIJcb42Df44cjy+O5A
         /kQg==
X-Gm-Message-State: APjAAAX51VCGhLC2Ympbu+mELDrMv2YnFOyyYncO4Wsy9HFxi6o28OqY
        VSG5+LihlwvTT58X5Pwd28801Q==
X-Google-Smtp-Source: APXvYqzK9c3JqRxvkrNr7vtfvTca6Y5lZHCWWdpg0BHow713tvjHfGSQqtezy7/bI8OVhP01rgLxXA==
X-Received: by 2002:aca:ea55:: with SMTP id i82mr7421001oih.33.1559156929781;
        Wed, 29 May 2019 12:08:49 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id w79sm136935oif.4.2019.05.29.12.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 12:08:48 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Ben Segall <bsegall@google.com>, Phil Auld <pauld@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v3 0/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
Date:   Wed, 29 May 2019 14:08:45 -0500
Message-Id: <1559156926-31336-1-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog v3
	- Reworked documentation to better describe behavior of slice expiration
	  per feedback from Peter Oskolkov

Changelog v2
	- Fixed some checkpatch errors in the commit message.
