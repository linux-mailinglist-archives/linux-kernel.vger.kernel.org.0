Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F51E18D11
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 17:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEIPig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 11:38:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38293 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfEIPig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:38:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so1521550pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5YwQ7pSduzStb02SylGKVrjZm5E2uXA+GvWIb5JRr7I=;
        b=H5YrD2LANg0XDBX7Y8dX3WkFbyNGuKqmc5AwTCh3L8XKM1fCfygAH6ZZiCtp9tqqlD
         RxH8VecF/mXAPPFyCplZvNSO/9v006AbuWT/n6pPPRhI4nrP96doRX6Xq1znHbO4VVQ/
         G3kcSqpeEXJBkxBuWZHB/O1+9AApxfAZUUs9ezP38DJDepTh3xANJ/OLFaHQBMLj9Wm5
         MuJG8j7w2G1sbeBewcHXyCRfwk4iMjYXN1tb8k0QAz9IxchlTla8nJbb1BQ7G/YzDMOO
         Y/KBoLfQw/G64pRnlHf18UE8WP4NpZegiPor/cUFu6kDqVkX1EEz1g1AITn6aA211vqv
         Dzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5YwQ7pSduzStb02SylGKVrjZm5E2uXA+GvWIb5JRr7I=;
        b=lMZbX/DeuMJZeyvPrZmChtzNINXXd1Fj0GomwKhGeR1Ru+pQXA8rKXYmox3McOs6TF
         ZnXFm30bvQPUJD4mtzhnAqZgzH8/qTzt5tgjGzFU0SPIz4exl1/0vEsiWAz03qnzQXYj
         qyXl4xC/ccWFXO1s2N/RaGP4a7GmNqM/Ejtu+6HBl5J9RofXrW3XdoiyLNToPVcbABM1
         Ceq01y2dWypybIYYj6JBTFooulWb+flxj24rYJnpaoeBTzP6s6Hm8oCegwtamH0dWhGQ
         GFw+BdUoYqwwiL7i4qP+HhZeO39KDwznk4YbLwWxUmx1HM/SgTY8r9yO3elNvFr8IviP
         JdHw==
X-Gm-Message-State: APjAAAVq2LJccIwVcTDNkQaIH+cXgvVT4qIF7tv/ErYtPbr2p92/XxYE
        zybT/YEmgDz4ChAkOIOSzJFNVg==
X-Google-Smtp-Source: APXvYqxqQ737rcyEeTeKDmNxTm839RB0ZfC55simHYlp8b5BDIhwUb8yXIjBmSqvxOC2ppuwaQgrnQ==
X-Received: by 2002:a62:2b43:: with SMTP id r64mr6112838pfr.210.1557416314921;
        Thu, 09 May 2019 08:38:34 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id i15sm5711248pfj.167.2019.05.09.08.38.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 08:38:33 -0700 (PDT)
Date:   Thu, 9 May 2019 08:38:28 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Joao Moreira <jmoreira@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v3 0/7] crypto: x86: Fix indirect function call casts
Message-ID: <20190509153828.GA261205@google.com>
References: <20190507161321.34611-1-keescook@chromium.org>
 <20190507170039.GB1399@sol.localdomain>
 <CAGXu5jL7pWWXuJMinghn+3GjQLLBYguEtwNdZSQy++XGpGtsHQ@mail.gmail.com>
 <20190507215045.GA7528@sol.localdomain>
 <20190508133606.nsrzthbad5kynavp@gondor.apana.org.au>
 <CAGXu5jKdsuzX6KF74zAYw3PpEf8DExS9P0Y_iJrJVS+goHFbcA@mail.gmail.com>
 <20190509020439.GB693@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509020439.GB693@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 07:04:40PM -0700, Eric Biggers wrote:
> And I also asked whether indirect calls to asm code are even allowed
> with CFI. IIRC, the AOSP kernels have been patched to remove them from
> arm64

At least with clang, indirect calls to stand-alone assembly functions
trip CFI checks, which is why Android kernels use static inline stubs
to convert these to direct calls instead.

Sami
