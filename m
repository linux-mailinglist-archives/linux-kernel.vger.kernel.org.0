Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891F945EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 15:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfFNNnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 09:43:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41550 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfFNNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:43:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id 33so2463452qtr.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aXm35D07rUjPalP4CfdXm4RG5Oa6TLe+BWj9APerSEg=;
        b=QR/Frpj4TG8mlIKMQ8x4IzLOAFOk25NuIc41EaC9lVa+w/n88BtrrXCtofyiOLcBhQ
         Ezeq0yN2wzhUdN1vU2w1zT+V527yXqLZF/+MLPfVmTNAtX7P4rRVe0DL2RGw1IGwvkhj
         0KDirUSeO28izbosQHeBo0cYVQuorCRyA8FkTx4KP3ZVVmk2W76yy5ocUMvKbrVs7f5E
         G+deGxfel0FA+FY110QfZw7k7b3xnpeyMTNzP4c19Tm8CffN2A/jkYI/34ElKabeYW5I
         b0HU2seMrkx9Fzxz2rqbfqxlowdUUvCJuIQL/eGCkPMU4cK5IaFV7RZmAMvH+obj+Kr1
         xdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aXm35D07rUjPalP4CfdXm4RG5Oa6TLe+BWj9APerSEg=;
        b=cG7gfM4MYP7XPANjZe1B8QXKPN6YqNYbuLR5vz1DzlCGMcQ790RP8i5LLlBWdM646L
         WxDHqo5UTPd+rivkPeiMFG/8yoPTkao31Bey52oQnKpLOS40VlU0GIKF0FJSFpg23umX
         oMnjuAky5PrvdYdDFqDSgrwOfcU2WXc1zg5U7416l6arlNPThF/zabklS33c/sgfTKvI
         SJvxEF2JV/YQGGFSz+9MK+vr7pAbmzA+5ogCLXjWEzCe+mZPxLR49dycmt0zpijF/jwH
         t4wsVO6/rmwQ3QyOzlpcU4zIRvUOBhfCb4hUMPvetuLENpFjUc9NKuW/YkNpc0ZuzUYK
         zPUA==
X-Gm-Message-State: APjAAAWe4l9gdCcVyffxObNUTlidPUuX0DF2nM13b/uJO29T9+JkRmdD
        iSM0AIImPlPMmWs6FlTUrhSTOg==
X-Google-Smtp-Source: APXvYqwz2/lYE4zseDXYhlp0RL/XY7Q0dZxV33vLDM4hSXrLx92LsZ3CWxcDYpnpK2WqRaqGxcv0MA==
X-Received: by 2002:a0c:ba97:: with SMTP id x23mr8397472qvf.133.1560519825110;
        Fri, 14 Jun 2019 06:43:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id s64sm1507782qkb.56.2019.06.14.06.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:43:44 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:43:43 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/8] blkcg: implement REQ_CGROUP_PUNT
Message-ID: <20190614134342.rtm4iwxgzbsueyfg@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-4-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-4-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:45PM -0700, Tejun Heo wrote:
> When a shared kthread needs to issue a bio for a cgroup, doing so
> synchronously can lead to priority inversions as the kthread can be
> trapped waiting for that cgroup.  This patch implements
> REQ_CGROUP_PUNT flag which makes submit_bio() punt the actual issuing
> to a dedicated per-blkcg work item to avoid such priority inversions.
> 
> This will be used to fix priority inversions in btrfs compression and
> should be generally useful as we grow filesystem support for
> comprehensive IO control.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Chris Mason <clm@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
