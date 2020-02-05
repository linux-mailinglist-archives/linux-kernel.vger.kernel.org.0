Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A938B153586
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 17:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBEQq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 11:46:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43114 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726359AbgBEQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580921186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M7hFAEYpi25OZAJ3FpIbfqeOjel9eL1CL20O4yOxrIg=;
        b=Gi8lQJk6IxWm9MjCIICs9yssxmBf9372Z1Z0O0zoEfYnDpyW2H4Px5k6DxRgdptjtK6r5s
        0XgjfjjeLdY+11/qOq2cFaVAZpHu3OowhuYm1bq3s2nkFRf3RZLkox7cMHQu+umoNp4jpL
        MpYm4YnMdWHe6ImeSIDPxx04KttNI/M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-56ECc4rQP1KXE1oZyx6xIQ-1; Wed, 05 Feb 2020 11:46:22 -0500
X-MC-Unique: 56ECc4rQP1KXE1oZyx6xIQ-1
Received: by mail-qt1-f200.google.com with SMTP id k27so1721805qtu.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M7hFAEYpi25OZAJ3FpIbfqeOjel9eL1CL20O4yOxrIg=;
        b=hyI5AIP5tnW9eCMAZcLkyYW3fqTrLiQy/dlbN9iPnttRPLAhWzDFTOvLmrmMuivvXH
         pfOW5/XmCtb/XZkjuqRGEvGxdGBLSMhXdFTlA25wGwuXk393lXPjhbktQHSKbPr0MqEn
         gg9IRpn/IO6AaXwYdkWyioSpwnnfZempbdBxqzSofZse8O7gX9/B8Rlj5T3ZCLksYVxV
         LGt9M3jOi7IiatzypV1dxyxpQLnR2GZgndx65VeK3Ep0paG5wVlAUVdQOZ0u5k/aNi7G
         kj6779JLx1ffr4LZBqsNEd82C/tyvO776vuZHVqgo82EwYa5kFsnXQpp3CALu41ISm0V
         lbzQ==
X-Gm-Message-State: APjAAAV+4X41691yWIfm5FYk1CZLjF1AL7veUfRnp9d/VsmG/v0IqvLZ
        gyeDlmS4dQ4oZh2vO+2p0XZCP5cCfXKzh6C+SsHckI6yNS2xDtMihwnuYzaLTEdRFyeuq2HdeVf
        sOyXxca3SN16Mow7yxwIHGO42
X-Received: by 2002:ad4:498d:: with SMTP id t13mr31655717qvx.58.1580921182148;
        Wed, 05 Feb 2020 08:46:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxzevODXBhDfMMTQorefgWoeFyo9tbv71If2hqARRkA5O2BGwW+pwMmPwOC5DMC/NssdMI3g==
X-Received: by 2002:ad4:498d:: with SMTP id t13mr31655694qvx.58.1580921181856;
        Wed, 05 Feb 2020 08:46:21 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id q5sm91326qkf.14.2020.02.05.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:46:21 -0800 (PST)
Date:   Wed, 5 Feb 2020 11:46:19 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 1/3] kvm: mmu: Replace unsigned with unsigned int for PTE
 access
Message-ID: <20200205164619.GC378317@xz-x1>
References: <20200203230911.39755-1-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200203230911.39755-1-bgardon@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 03:09:09PM -0800, Ben Gardon wrote:
> There are several functions which pass an access permission mask for
> SPTEs as an unsigned. This works, but checkpatch complains about it.
> Switch the occurrences of unsigned to unsigned int to satisfy checkpatch.
> 
> No functional change expected.
> 
> Tested by running kvm-unit-tests on an Intel Haswell machine. This
> commit introduced no new failures.
> 
> This commit can be viewed in Gerrit at:
> 	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2358
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> Reviewed-by: Oliver Upton <oupton@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

