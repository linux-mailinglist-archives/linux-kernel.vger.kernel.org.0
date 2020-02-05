Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A87C153032
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 12:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgBELxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 06:53:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50448 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgBELxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:53:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so2174990wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 03:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7c21mUgID7h0v/liGmDvpLJPds8QCzrhKbe5YghGfNU=;
        b=XzBvFS/gNPLwRqEZskjfYMk/zF3hLF2ozbayiF2V8toWM2Jd8ZmOzU1spStKXBPW1Z
         pp3F139qTerDvt9p0tXxK6f93DNGW3/HW6F2n7cnCFX8iAKKwQIMKp8iAtBsgki3f6oY
         4zWD1hplq95A5ySRFoc69aE9bBRgEEAvTGAo9a07cEhnO6/NJ67apgSL9EIVu6O5anHC
         oa3P4wQJJuiZBqTmA+XGMdZy2LUo8yrGd6+Lzne9Wj6w3UlG4OIJR/0YBu7OWs3sdfru
         UFCr52u0qf+/qZ4UJd7YQdUK6DXtQM03g2+977NDjNFrM7C32/WEMbJZb4mGJ1vqSTFq
         IoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7c21mUgID7h0v/liGmDvpLJPds8QCzrhKbe5YghGfNU=;
        b=Lh3cVbzAmzcMZ6FN7xNO8jlthn9gjhwfggOWUFXOMo4SUVFrvBI1D/zE8EqZoDqPmq
         HroBGB0Nj5C4pNUNIJiTY04B3Nb6QjK0X1mfRK9IKHFl1QR0wJ6CEe7y+UhYBpprPRdE
         pyBBHyQdgyM4HXwpcRWOSGYxiNG+2eTZTD3gg2f6k+1dD+68IDPQwqNGzDR332Eicumy
         ArHAd9HxVJez6HVb07eK5YMok8XDvB5YqefQ0Sdj3qnNJ8v5zTkq9FngeYzAhIA5rnq9
         zN4PLRrrKSNl21pD0kVE13K65NGmtQlkvlzJtHeSM2bOIkcn9y62yS/nkceOjVzumOHi
         9gag==
X-Gm-Message-State: APjAAAWkV8I61EQIFZ0/afzrIZwM24rPzMLk8ADOHk8edIfNMj09bG+x
        feJndsMyB82rKLsgXgyCUAN6Qg==
X-Google-Smtp-Source: APXvYqyQ4DsnaFrISQMDwBLD1siQaApJWGv4n0J5CTrpni9Rel5cJt6EM+SFaa4rQHKcx/Sxg/zipw==
X-Received: by 2002:a1c:44d:: with SMTP id 74mr5584108wme.53.1580903615183;
        Wed, 05 Feb 2020 03:53:35 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id z19sm7549943wmi.43.2020.02.05.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 03:53:34 -0800 (PST)
Date:   Wed, 5 Feb 2020 11:53:31 +0000
From:   Quentin Perret <qperret@google.com>
To:     Matthias Maennich <maennich@google.com>
Cc:     masahiroy@kernel.org, nico@fluxnic.net,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-team@android.com, jeyu@kernel.org
Subject: Re: [PATCH v2] kbuild: allow symbol whitelisting with
 TRIM_UNUSED_KSYMS
Message-ID: <20200205115331.GA74296@google.com>
References: <20200129181541.105335-1-qperret@google.com>
 <20200131131508.GH102066@google.com>
 <20200131174055.GA8425@google.com>
 <20200204144415.GC42496@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204144415.GC42496@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 Feb 2020 at 14:44:15 (+0000), 'Matthias Maennich' via kernel-team wrote:
> That definitely looks like I would expect that config option to work.

Good, thank you, I'll send an update.

And while at it, I realized we could actually pre-populate autoksyms.h
very early on with the content of the whitelist instead of having it
empty. That way, there's a whole lot of things that will be compiled
'correctly' from the start (that is, adjust_autoksyms.sh won't need to
re-compile them later on). And in fact, if all symbols used by in-tree
modules happen to already be on the whitelist, you'll build a trimmed
kernel in a single pass, which should improve build time a bit I hope.

I'll add something to v3 in addition to your suggestion.

Thanks,
Quentin
