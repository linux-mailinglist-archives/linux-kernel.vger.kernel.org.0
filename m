Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8D517A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfFXPuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 11:50:22 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:35220 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfFXPuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:50:21 -0400
Received: by mail-ot1-f49.google.com with SMTP id j19so14026480otq.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=8myhvq178LDUl7I4FoNI+Lu1VTlerrD1c45aJYqC8NU=;
        b=PUNk8yovZHbXkBBep/263tf6wYeTeUwWG1Nm+qCEz55Lk74D7Um6Q/3MRiSppY2Yxx
         h8fbYzz0b6kwTpKv4XPL8ixLfKbD2xQkZ7SG5yfmhSKG7h2AtyxZaoyzDV/Er9tzjy4w
         dEphCN+uJPMoyODXqPInVyJ33blp2WrB0yQuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=8myhvq178LDUl7I4FoNI+Lu1VTlerrD1c45aJYqC8NU=;
        b=W17KCwQvFEGje/L/M0cY2N4rvL4f1dN4xZaAP5tF2uWHW0HcsUfwzzMUnzLWipH5u5
         82CbfqaJT6qcMPTb06iztEEM6zqlY4E6w9MUHKl29DfLrIzrzIRTuJMwg8IPAJcfy88a
         oqyhbY3hvdc5DbdoagxbISkGj0jRc5Y7VHMU0MAYZ+ks6odIfgZ2muGEaWBmB42Cz4jC
         pGMmAAgeImuQ3nLpBlWdFd5AWsxfexn75kHXQCLF7qnxiKHD8g2W1Qgd42s4lf+bAEcv
         uTuAU+J5IlMhN/s3LSpiAUyOcTcaL9QxxCgJOtBhDEJCYPMNz5q0HlxjgidfB9/Gssqh
         bNmg==
X-Gm-Message-State: APjAAAWzZu7VZCwxdr5a0WbrahnutKXMq96/yCGINLJvoq3S3RKGsIkx
        7DmDW24V1cAQ/R+niM2Pt/Blrw==
X-Google-Smtp-Source: APXvYqzbMD+f7wzKYiZDRTmef5MK5GFoBYRdjfKDopr15+02mn84uuFdvhoh59tR4YOB9jZpwPbYXQ==
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr48237869otf.137.1561391420731;
        Mon, 24 Jun 2019 08:50:20 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id x88sm4237710ota.56.2019.06.24.08.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:50:19 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Ben Segall <bsegall@google.com>, Phil Auld <pauld@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: 
Date:   Mon, 24 Jun 2019 10:50:03 -0500
Message-Id: <1561391404-14450-1-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changelog v4
 - Rewrote patch to return all quota when cfs_b has very litte.
 - Removed documentation changes, as bursting is no longer possible with this
   new solution.

After the suggestion from Ben Segall to set min_cfs_rq_runtime=0, I came up
this in an attempt to balance the desire leave runtime on the per-cpu queues
with the desire to use this quota on other per-cpu rq.

Basically we now check the cfs_b on each return, and decide if all the remaining
time should be returned or to leave min_cfs_rq_runtime on the per-cpu queue
based on how much time is remaining on the cfs_b.  As a result this mostly
gives us the benefits of both worlds.

