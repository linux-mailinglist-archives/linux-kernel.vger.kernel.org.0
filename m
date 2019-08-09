Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F9688564
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 23:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfHIV7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 17:59:17 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49044 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfHIV7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:59:16 -0400
Received: by mail-pf1-f202.google.com with SMTP id u21so62302320pfn.15
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aHPozI+kRmLZ/MJlV7luwBtUMjEIFkgoeCnOJismWTA=;
        b=XmhQBsfMHALmx6QOLM9UBumnO7+O8bCcXOWfbEhvnKPRZtyZjK8Tox3QlWh+5SsoHo
         nSFWQ4AXRB5rGt1kt3KE4aQEc1I3c3lRuL9npZ/+GiDm5vL+RU7MnPYmUFcMbJyKb6ra
         WcTRcRm2FQ6DDaHqNyLsrOSB632i+21o8ygllWidqV7vliACQwXLx06D5cWErjUfEvvk
         oS6tlLYGXRIUWgi8FZPNnxObKBs0OQf/b3sPOwVn84irLt21e12rwexZf1dIbzAlT4UU
         pC9A8HRAZ1JoHP5xAxw+zFJ7gBhI3E9LOkogGnAloitRhXpmiawVE738kNJQ2UpHPLsi
         ecbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aHPozI+kRmLZ/MJlV7luwBtUMjEIFkgoeCnOJismWTA=;
        b=M2Rqlf+ufzTybVB8TVyBZN3JsbUXmQr16MuQyGUgBgynKDzw9iP2SOr0UDkN9OgO0k
         agG301iawaRbtGNzKyfQ0d5YBAByyjeD1n4HsINOvhiTiNAOozu62sJ64Fyjpq0Q9gNN
         eSEZy8iSfLD/XIWCXV9Uu4EuJC+tolAF7LfDE5MetxwlPiN9k+nXxywmVxhmX6pQ1W1Z
         AAN1+RNGmgmuchcNDq9SxFJkWdmSl4heWNCUKHgaHHvPWNTy5isqmu9HCahNI1zlZaA5
         ZWxqrxRsAm3gPIx6Z25WuD6ynFWydKFsOpxIPovFHec9FmDcupkNR6p/OhjNetVHs+x2
         VBvw==
X-Gm-Message-State: APjAAAV0C6B/0lhsDmi5yGpLWwpSv2q/V7uiZKPtjen0XIuddWoYnbhF
        B8zLXNK77eo5oT5ruAV/mtDvNpZNeA==
X-Google-Smtp-Source: APXvYqyz8CcNShPWSHPO/FAxHKFz6gmTSkkw/fYF/3ATwxbLzpgLwoS9L+u1s86mqzbQrSNfPjRKv0frajw=
X-Received: by 2002:a63:bf01:: with SMTP id v1mr18841445pgf.278.1565387955717;
 Fri, 09 Aug 2019 14:59:15 -0700 (PDT)
Date:   Fri,  9 Aug 2019 14:58:48 -0700
In-Reply-To: <c7ac79dd-c15c-6edf-153f-71dd8f754a93@arm.com>
Message-Id: <20190809215848.47736-1-yabinc@google.com>
Mime-Version: 1.0
References: <c7ac79dd-c15c-6edf-153f-71dd8f754a93@arm.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: Re: [PATCH] coresight: Serialize enabling/disabling a link device.
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

>You may also want to protect the refcount checks below with the same lock, just
>to be consistent.

Good suggestion! I didn't protect it because I found other places using refcnt.
But it turns out they are not link devices.
I have uploaded patch v2.
