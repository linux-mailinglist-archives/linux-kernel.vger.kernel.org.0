Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B4D19BD5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbgDBIPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 04:15:07 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37490 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgDBIPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:15:06 -0400
Received: by mail-wr1-f52.google.com with SMTP id w10so3077885wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 01:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JTeGTG8SF3wrV0puV5cbzjV2cRe6SOdxMC+vwAV2NYY=;
        b=SHWvMagwQQUMs41YB+fGjaGqGn4Nr4uOwagI97vyh3rT+GYE0ja4t/UJRtvFZEBPBo
         4/HWZROygDDm3DDDwgz505Wd1lZjCkyi0gQ2EtpdyBPfKN39K4ojWF8l6BEhsoxZoWEz
         0eWm8p7iqeJdNBqU/K7gXFuiI2WBWZRRTedL4C0Cq1n3f3hlGeb7dMsCJQuGZzAg98yk
         72x0pLUq06agM2j9N3+dNGGHC8UiyBrl8zhprp7P9z32nZSCNvvqQKAuZw/vat5HqbtH
         h82OG7Nw50aD7Tc1kgVeiJmFWek1ZaV6DlD671ejaa2ilwegQJmsLrXmMXhQH3pObDTl
         6GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JTeGTG8SF3wrV0puV5cbzjV2cRe6SOdxMC+vwAV2NYY=;
        b=PQjMC2LeXy6msWSKG65O60yV/ZOXTw4XLu9z+jLVGqdPYGaEKeNlrnG0yZWlwGaKFM
         4vnQFbFlfWAkt6dhJNp91arCpmAmbTMUPwtQuLiB6IkwP9MaIQm++5Ul5LABXYEbYD7l
         XsILmXrBGKmitak+gcE3+3TvtdsuTyJTznKZlhBxGQ2FOcLY3vTTxgCKGKFb9fwch+4y
         RGzycN39dKSBWeDyJf4MkWOld9qC7ZjsvYANowYMN//MA75ZS/ckLseQ8SU8yg79lc0i
         ZNtyV3Kh3tnhTtJUlD5HWwLQmQ/lO0O6YRc6xPe1qIhnEC884KpPhg+m9wkydvBB3Bn8
         +NMw==
X-Gm-Message-State: AGi0PuZs/NRuNAJvE2A8X0XC9xF/FZAcj/hhHtNfWTobQkJLvpXWpsLr
        AP29LTVT+BSHgNxXpB8wGdE=
X-Google-Smtp-Source: APiQypJBPDmzWW/MeDOBKndxkYCEH6te4PTkAa6oIGgmP1nYnHz0nLk5XNs9Hs7zXsnKC/5V8wgBlw==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr2183420wrs.391.1585815304815;
        Thu, 02 Apr 2020 01:15:04 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c85sm6130804wmd.48.2020.04.02.01.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 01:15:03 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:15:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/vmware changes for v5.7
Message-ID: <20200402081502.GA21353@gmail.com>
References: <20200331100353.GA37509@gmail.com>
 <CAHk-=wim0vZMxgxmu=eW4pCqExbcJqswEvK=VYuyqkB-40koTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wim0vZMxgxmu=eW4pCqExbcJqswEvK=VYuyqkB-40koTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> All of this series from Ingo pulled.
> 
> Looks fine so far, my only reaction is that "Ho humm, now Ingo is the
> main -tip user who doesn't sign his pull requests". Both Thomas and
> Borislav have started doing so.

Yeah, will do - almost did it for these pull requests, but will start 
with the urgent pull requests instead. The reason I didn't is rather 
mundane, I didn't want to mess up a dozen pull requests with a new pull 
request protocol. :-)

Thanks,

	Ingo
