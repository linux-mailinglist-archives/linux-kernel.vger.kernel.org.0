Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8C1B0C40
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 12:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbfILKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 06:06:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36050 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbfILKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:06:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id f2so17065681edw.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aqH8fHtjT3IC/e5deArdd8oGX2wHZ4L9R7PbYi/ofyE=;
        b=i0kb28AFynzLDWYc/Md76wO+4Lrr7IrS1+6jbZyJp7B8cHfwzc/YZfeotZo+Pv4uZ7
         UAKdPDOo0lrmH5R3sOlwBQOxvcLChktxmsEkB+2uTyH+Rq5XfI65O9Z94Z+obWutx07s
         XzEavAok9ThOFRQDiddgAkrUpPD9vKHfgSV4xMOrhKHaSN0oE7H4Yr4VBAe2HEbZqAnb
         9KSSc54fY9hiuvthnxGax8VALweMokoc51TtUn2OguvauYy6k4Wf/eRQakDuDca+32zF
         nVCVZN16xOi5r9rxTqinPAKy8k7PUWvLiCbD79ga6QA+z7+zIgZuSPfhFacnfdsxQf4c
         9vJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aqH8fHtjT3IC/e5deArdd8oGX2wHZ4L9R7PbYi/ofyE=;
        b=sqgJ68fCSgZPG+2H/w+LjCE3EEExASPsWVpX3iz2DRMa4rFj5hcpgu6h+xuFsCQEok
         YPuIQf7CBDxRyXqxHTfgwHxSQ1g5CTP8PvjHO+NaB+9kAeDVNe8P9d+CzSV52NtRzXb8
         Zewnbo8dRXWbhKojCWeCgwfqWLRAPyDCAUkc/68pgAD0iIX5cF1BtqztF/E1XQMYuRzE
         cJIBHnzaNwLzdBSSC/tFZh+oq5gygPCKSJXBuA/dkHkvzb1ANR/sa1BysRPx/B7njqZD
         cBZ/TP0kpa1ZbWJsuC0Wg1LDHDg+0QU5suBHefeU/g2CPDM1AwZIFcVYGE5zQ02zCBXK
         Ul8Q==
X-Gm-Message-State: APjAAAWJbRanJGPvJtPxCBh9RqVZ3KchuQXM2N+nJ/+P2hmZymsNHYxt
        ZmUC0n+tmG+TlUPl9HSBOyzuF+4WzWw=
X-Google-Smtp-Source: APXvYqwr+ZxopPgubxD20LDe8gLP9CjjeqgoPlo0lC+2DPB6zZR0a/xFGp2E99s4bGIqlKqsUOHv2Q==
X-Received: by 2002:a05:6402:125a:: with SMTP id l26mr4416227edw.95.1568282802039;
        Thu, 12 Sep 2019 03:06:42 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n1sm118790ejc.16.2019.09.12.03.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 03:06:41 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 68FF0100B4A; Thu, 12 Sep 2019 13:06:42 +0300 (+03)
Date:   Thu, 12 Sep 2019 13:06:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: lock slub page when listing objects
Message-ID: <20190912100642.57ycbflh5ykcgttu@box>
References: <20190912004401.jdemtajrspetk3fh@box>
 <20190912023111.219636-1-yuzhao@google.com>
 <20190912023111.219636-4-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912023111.219636-4-yuzhao@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 08:31:11PM -0600, Yu Zhao wrote:
> Though I have no idea what the side effect of such race would be,
> apparently we want to prevent the free list from being changed
> while debugging the objects.

Codewise looks good to me. But commit message can be better.

Can we repharase it to indicate that slab_lock is required to protect
page->objects?

-- 
 Kirill A. Shutemov
