Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9F5C852F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 20:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbfHGS1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 14:27:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42894 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388207AbfHGS1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:27:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id t12so777636qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5PFa4JWDuQYpY0nKXNpEXJUqm083OLKX2xbfgQVH+Ec=;
        b=K3uMShq9IQAb6I2sO3P+7I7si5Enmm9GpWrimK80/csietROr4+eLKr1JFQ608AEpt
         0b2NW3fu//AG5WAx3TyqGu58FZDCk8Qu2//0pWqMhB8nK3HJQ5NlQW1g8gqUu9kHKbk7
         HBJkoLddmt+XxkJZeJp0UneKHkCxmNUHOLqG60aYuf7tRUXtnKDFutzJPDZ+EuGec8GB
         czXDVC9nvGxKpl4ZcK4cXukFAJYzgoi5tDiHxHecIyjLfLhgHq9x4bmHt75SgJoOQvBM
         wArgSDuwmk2jPt9KU0Fl6p+cmVCbg3vACdWeCgn6gktdUTyQc4MXKXxCN3jcZGBCLHqI
         k5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5PFa4JWDuQYpY0nKXNpEXJUqm083OLKX2xbfgQVH+Ec=;
        b=YywsNtrTVCGMC5CawwkA31ifTrDFzuvHYGCH0jT8osSIa6WajLsLnqlewkDbl/1jiw
         RwAEI9O72E2hPz6WyhD9wiqk/SXABAVL9mib2bSeLZG5hCKYo+gcUc12BuRh7bfVSmYN
         aPfU+9krXdBkKd9NRjBMhqzcPo+RR7Y0yho1cUsfFjiYtOjxo//tNVP48zxTKrgnyUTF
         vpm1jF1UFRZHSXeJqXLzZ/RlbUhhZKVTN+1VKJr612/f433mLxLT+Tow0jF3OPMZ5RsW
         BIg6JXfibuq+u8Cdzb0FllWa7NUDJFS6NrypQ4gvOkAlCrDbol6h953DuGhW2kRKyrO/
         nMRQ==
X-Gm-Message-State: APjAAAUpPRH/RtGVs2NEB4sum+U5h+YfsDuI55KmdnFnR8ovAB9xoonX
        ziEqgAum8rlg7HY/goFXCGI=
X-Google-Smtp-Source: APXvYqzRvuwaQF7v7o8PfFQd4Ik8WrNOZKYeim7pkHTMXo8kLpXA12hh964d0jOigi4w1mM4yxR2Pg==
X-Received: by 2002:ac8:66ce:: with SMTP id m14mr4895305qtp.206.1565202428781;
        Wed, 07 Aug 2019 11:27:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::6ac7])
        by smtp.gmail.com with ESMTPSA id e125sm37800534qkd.120.2019.08.07.11.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 11:27:07 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:27:06 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ipmi_si_intf: use usleep_range() instead of busy looping
Message-ID: <20190807182706.GL136335@devbig004.ftw2.facebook.com>
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
 <20190709214602.GD19430@minyard.net>
 <20190709220908.GL657710@devbig004.ftw2.facebook.com>
 <20190709230144.GE19430@minyard.net>
 <20190710142221.GO657710@devbig004.ftw2.facebook.com>
 <20190801174002.GC5001@minyard.net>
 <20190805181850.GI136335@devbig004.ftw2.facebook.com>
 <20190805211821.GG5001@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805211821.GG5001@minyard.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 04:18:21PM -0500, Corey Minyard wrote:
> > Yeah, whatever which makes the common-case behavior avoid busy looping
> > would work.
> 
> Ok, it's queued in linux-next now (and has been for a few days).
> I'll get it into the next kernel release (and I just noticed
> a spelling error and fixed it).

Looks great to me.  Thanks a lot for working on the issue.

-- 
tejun
