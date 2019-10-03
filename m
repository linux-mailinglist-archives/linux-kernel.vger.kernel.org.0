Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF10C9DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 13:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfJCL5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 07:57:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39799 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfJCL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:57:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so2072805wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 04:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4fN37HHf4WvmYouQpSxjp4nAU2MI4eZ1HtmfOGNitFs=;
        b=EyyrVpHwTAEisTRKCYqA2zwPzmy1guRNkMs5aKw3lcv+jFrHwa6sgW+FlWYY9C9mvl
         V6oN+m7xXcAsDUm8T8mKlBoOAEbBPfxVB++z2VjAXPVapLXbRbcOCkLdCpWUGiB1GDDS
         UPAymW5HM0f3T6czyqIcHlv/0iV04tNWkCDagESGjUSlNjTDRSoB/1oNjrDSCw+p3sVZ
         3G1BlkkpFO4kUO8D+495KmNKxXJyew2l6fxpBfNs13MbKBat44XPbwFKCxLQxyVrlMip
         dspAEEo6oInbdYFSx5LGWZCUSUac+5+F/VxcXceKt6K8Yxy22cK7i2pMr2Rj+USZ8w10
         Al5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4fN37HHf4WvmYouQpSxjp4nAU2MI4eZ1HtmfOGNitFs=;
        b=t/vPmTf1PviIPDqomrjqggntfOuXRJ8vuI3OE2cV1enlE3tCEfHH1wUfW5yJ+2R2Ln
         p5eHgPb0VTKlfAFmwMir5+sxaT7gKULSCTOkjws86O0H0ADEOAnZZWQhhaPMGSqdxTvY
         5sDHLLeqxCgE4/CvdItwXPiQaWRlPQFALmlor0dFLQtEwgGiIiDmJq6GkSr4aqofboJU
         Q1rl6TPuB3LmxFA7+RLvYNokO3Sc2dhPo2FeBHGgL2HgXfiFwxFZfXqgEdIFdUfo++5X
         QjNdj/turTvKrDSszHDlvfp9Pa7sgR4SnpDRpb1X2DjIFn6MDLMq9G9YDWebvx/FUJaK
         YPMQ==
X-Gm-Message-State: APjAAAU+g1mtee9Ohoa+7K1+VIFuThsrlj2yKb0cym4xmAMrEeePHT9e
        hMD1P8PokRWyXC1nUdsulE4=
X-Google-Smtp-Source: APXvYqz9KisdfD/zsez2nUnQlEHc+Uoigs79jb3o+LDfLlcud/9uMZ2btJJUBZHbH4FMta4v4MDtQA==
X-Received: by 2002:a1c:2053:: with SMTP id g80mr4621307wmg.18.1570103854561;
        Thu, 03 Oct 2019 04:57:34 -0700 (PDT)
Received: from andrea.guest.corp.microsoft.com ([2a01:110:8012:1010:414b:bdc7:a2f9:15b6])
        by smtp.gmail.com with ESMTPSA id c9sm2727814wrt.7.2019.10.03.04.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:57:33 -0700 (PDT)
Date:   Thu, 3 Oct 2019 13:57:27 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Paul McKenney <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH] MAINTAINERS: Add me for Linux Kernel memory consistency
 model (LKMM)
Message-ID: <20191003115727.GA13200@andrea.guest.corp.microsoft.com>
References: <20191002152837.97191-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002152837.97191-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:28:37AM -0400, Joel Fernandes (Google) wrote:
> Quite interested in the LKMM, I have submitted patches before and used
> it a lot. I would like to be a part of the maintainers for this project.
> 
> Cc: Paul McKenney <paulmck@kernel.org>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I don't quite understand how you ended up with that Cc: list (maybe some
other LKMM maintainers would have liked to receive this email, to update
their send-email scripts if not otherwise...) but welcome on board Joel!

Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thanks,
  Andrea


> 
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 296de2b51c83..ecf6d265a88d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9473,6 +9473,7 @@ M:	David Howells <dhowells@redhat.com>
>  M:	Jade Alglave <j.alglave@ucl.ac.uk>
>  M:	Luc Maranget <luc.maranget@inria.fr>
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
> +M:	Joel Fernandes <joel@joelfernandes.org>
>  R:	Akira Yokosawa <akiyks@gmail.com>
>  R:	Daniel Lustig <dlustig@nvidia.com>
>  L:	linux-kernel@vger.kernel.org
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 
