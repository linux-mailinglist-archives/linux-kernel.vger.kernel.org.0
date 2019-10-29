Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE08E93CA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 00:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfJ2Xk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 19:40:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39351 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfJ2Xk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:40:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id p12so174853pgn.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 16:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5wsNgUu1/P4JIurTC4HUnxDGW+gpw5nHaixpJkFjXGE=;
        b=hr2DbEaH9zzg7pMEkglTzruFvr/G6SucWqIpEJXNa80aYseQ/mNno7XeeptqQLsBYF
         Cptr8nRK6nskzlZeqMhWR0QHEmgkgjvBdZS03BTk47ssitfWG379IrAPNNFf9JTtCUBK
         7BGc7K4WEWU5F6wQ63pegpyWy3/rH2tYlL30M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5wsNgUu1/P4JIurTC4HUnxDGW+gpw5nHaixpJkFjXGE=;
        b=sQNCwmUg+HElyJq5Dh58TDtFIQyRD+K86/gqdrnHbDCTiCgPJzpht9BIWspJU2j+84
         v1/v8wqCBdUwEmyDWVf6WyFGN6Z4gRsRmvq6Gfmgd+D2hIa17t1eARzXMZ1kxbkwGb6B
         V2mEGLwwEyNLOfkUU8hoSaSmyF+QAqdHYZjmgH/KPXIt1o6X0Y7sKBJ7zrhxBi3+r/8a
         kdumpl9dDWz1sr03iAOmyhGZ4GH2RGPr2dcoWucUPUEpPYiVVY2kJVjHfLwBm9y777/2
         sgRSK0v3HsjHbLPIi9sFRSla2T59e/0q+3Yo6y0iynD1Fhu1kd8H5fQ3lB7HE0YoF360
         rCDA==
X-Gm-Message-State: APjAAAWtBI67E0Q74i6Kq8qOqYvWqBY5Oi24Rnh0IWa62gOXiiiX6Hax
        PSagej/8k/fFe6xOR6vfgX1E2Q==
X-Google-Smtp-Source: APXvYqyyFE5hvYmcxTbNJFzt5UcOMkXj9D0L0royyGvGrN8jqfXx6OS8jgHaYQhSxud/5j9vjsDIEQ==
X-Received: by 2002:a63:d951:: with SMTP id e17mr20748592pgj.243.1572392455225;
        Tue, 29 Oct 2019 16:40:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i17sm214510pfo.106.2019.10.29.16.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:40:54 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:40:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-mm@kvack.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, kristen@linux.intel.com,
        deneen.t.dock@intel.com
Subject: Re: [RFC PATCH 00/13] XOM for KVM guest userspace
Message-ID: <201910291639.3C2631C@keescook>
References: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 02:23:47PM -0700, Rick Edgecombe wrote:
> larger follow on to this enables setting the kernel text as XO, but this is just

Is the kernel side series visible somewhere public yet?

-- 
Kees Cook
