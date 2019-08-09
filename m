Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B18658854E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 23:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfHIVyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 17:54:24 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:53499 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfHIVyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:54:23 -0400
Received: by mail-yw1-f73.google.com with SMTP id e7so8332788ywh.20
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ukb1Zqvwt96yrIxgQQEQnGVIiIApqgSGRVfi7T0+Jj0=;
        b=sI2djgBN6cPLMgwD0FGqCodfYe+k2IT9TjQoBlBsI49JY2viIrggDlcrgzYYHGjYuv
         dCplPLLlGoc6MiW0IJTBaJAZeST6XSCpDG7qNXVZZRWJvQ+XtzHk52/rz5t4m+1OTv8t
         Tolwd/s7AKIq2Ucg6/SJKB7WCo7YkZitZmj0kJ4bZd2c3bqW5Du2NiZVP0iyeMlT3V/t
         Tx6xw8eA4zePcqFZR8w9RWGk9EJLi8uvO8XtK0h9VLVjLcUoWPy1sER4J3gpNnAkyiFM
         VZYsCzHop1nGaWVd8OoRtnojc7C87FmqalWjuDGlVLyspZgF8GgYnQwhLBFt3/phdJ9d
         pgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ukb1Zqvwt96yrIxgQQEQnGVIiIApqgSGRVfi7T0+Jj0=;
        b=dFeHx1vXE6qJTu6zlGHE15ITG2QLdHeZQ1QapsNQQm6egUEffmhkJi2OT0o9xHOtXY
         AprDdY70pHOUKUxgWc/204geadf/QZi3BAo75G5pi5H5jJG2fCMW3C7v1oIKEF4jDY2c
         HsQbI5lfkd78eWRzGmFjPhFgeToNYRYkZN9eL5wDpKElWmmed5AlQi0fz8NXJhf1DjhX
         cUJBq2oc3yeqx2e2PyG7aSAj/vxozkeIMG7ls3akTe5qhWJTndeKzlMvpUag2j2Fh3iL
         EzH7zKP34436ByCFS7LhLA7SSnN14QxFt/JRDDXjuTperq/fpsFUU9JFOVXCuSSPdzMr
         oRUg==
X-Gm-Message-State: APjAAAV6hX605snvon/ndo/AxRWnbOksH47lkJHsbZQdZ9BBmG79X+ry
        bMD0XBbt0sJ2m6PgOnBUWUasnOinUw==
X-Google-Smtp-Source: APXvYqzOSbj5Dv3h2QRRXyCuIOpRQUiHLc3KigrmqvjmGhP4R9rKNj7f0N2Ktsha/T/x2su4zoXceRuVSqc=
X-Received: by 2002:a25:6302:: with SMTP id x2mr16178910ybb.6.1565387662988;
 Fri, 09 Aug 2019 14:54:22 -0700 (PDT)
Date:   Fri,  9 Aug 2019 14:54:20 -0700
In-Reply-To: <c7ac79dd-c15c-6edf-153f-71dd8f754a93@arm.com>
Message-Id: <20190809215420.41874-1-yabinc@google.com>
Mime-Version: 1.0
References: <c7ac79dd-c15c-6edf-153f-71dd8f754a93@arm.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: 
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH] coresight: Serialize enabling/disabling a link device.

>You may also want to protect the refcount checks below with the same lock, just
>to be consistent.

Good suggestion! I didn't protect it because I found other places using refcnt.
But it turns out they are not link devices.
I have uploaded patch v2.
