Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716E84766F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfFPSjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 14:39:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46099 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFPSjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 14:39:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so12455601edr.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iPCYYZamo+zNy3F8fQgG7iaN+Rwo/mHiH/s3wrqNgI8=;
        b=fq9nM1XuKMlB21upTMUDBstuYzwIHIb7wZT9cVA/qQqOW3vBbyalAMsd4KVrlyyyxM
         DQ5OqY/39SBJZp/M3k9Co7ZamKybBq20LSuIF4USuUg5h+8NQnhq4UJC3/Dy3BtP8tBt
         pxqmSqolOWmMpmuBjvleVtBWbYmKih8LtbXM3SovouaY91fjzldcklbh9f6cIk+gLo7b
         zpTedXdFLaN9DlfdV1oiZUHIWsGkIsdZwoK1sNcA9hWcNr+366umU8yWNDZ2pT1+pVyQ
         IBWmqkpRIj9Lnm6mNzVgq1dp1kTNDdgzEvJVaf3IL4mqWoyoOn2RZbVd7W6sZJCC+Q1Y
         LMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iPCYYZamo+zNy3F8fQgG7iaN+Rwo/mHiH/s3wrqNgI8=;
        b=lItel91w4E9m8cSkUOzFZWp/ehyK2vWHFcq15/s3w6hpdsATwAbFHNMApmByakqJyw
         kXq6GiVoRUIm52fA58DJmRo5lur1s4Xzi0wLIHBFVFBeFQYxW1vpiwrRfaFVKmQfnYx7
         58n6C0agqr8YFDT5aj3Mhetc/g/osax7xYPEy7dMRk+YcOYBWMGhbBlhZUo2lbgewWzN
         /C4NQQeLoGRG2w+a1OpmxcTviHHV5cCl0KfQHmKzjayZe2Lc3v67uyBmTBXZ3tHdwwS9
         Q4PI+0Oa0y9xbODJTqbjQmZqT+qkoWwBUDg+ddi1AM2dfGcPPmIvpcd6zFnA6LH69Brk
         XV2w==
X-Gm-Message-State: APjAAAViNLlvBk63v8eVR+2WwOlk46QfepsN/4orIS0s3eMUoebRDBct
        GUUYqs+spNN7g4rxj/HbGkxL3A==
X-Google-Smtp-Source: APXvYqyxcrbgVSEB5rvrJtucmaNr5u4mzJkJi1l5V+VOwPXE2vrBOt8XRB40Dv0LVhh+vvQUAxrS8A==
X-Received: by 2002:a17:906:4995:: with SMTP id p21mr92348314eju.140.1560710373982;
        Sun, 16 Jun 2019 11:39:33 -0700 (PDT)
Received: from localhost ([81.92.102.43])
        by smtp.gmail.com with ESMTPSA id bs5sm1756042ejb.10.2019.06.16.11.39.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 11:39:33 -0700 (PDT)
Date:   Sun, 16 Jun 2019 11:39:32 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh+dt@kernel.org>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Paul Walmsley <paul@pwsan.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: riscv: sifive: add YAML documentation
 for the SiFive FU540
In-Reply-To: <CAL_Jsq+Lx+SBZ7_+0tCYJs+oA2zR9c+q2XdmFbEtpWxoLXVibg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1906161137350.26914@viisi.sifive.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com> <20190602080500.31700-3-paul.walmsley@sifive.com> <CAL_Jsq+Lx+SBZ7_+0tCYJs+oA2zR9c+q2XdmFbEtpWxoLXVibg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019, Rob Herring wrote:

> On Sun, Jun 2, 2019 at 2:05 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > Add YAML DT binding documentation for the SiFive FU540 SoC. 

...

> > ---
> >  .../devicetree/bindings/riscv/sifive.yaml     | 25 +++++++++++++++++++
> >  MAINTAINERS                                   |  9 +++++++
> >  2 files changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/sifive.yaml
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks.

> > diff --git a/Documentation/devicetree/bindings/riscv/sifive.yaml b/Documentation/devicetree/bindings/riscv/sifive.yaml
> > new file mode 100644
> > index 000000000000..ce7ca191789e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/sifive.yaml
> > @@ -0,0 +1,25 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Note that the preference for new bindings (or old ones you have
> ownership of) is to dual license GPL-2.0 and BSD-2-Clause.

Changed to "(GPL-2.0 OR MIT)" - hope that's OK.


- Paul
