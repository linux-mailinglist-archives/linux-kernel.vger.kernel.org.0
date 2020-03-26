Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69C194328
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 16:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgCZP0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 11:26:48 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36895 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:26:48 -0400
Received: by mail-pj1-f66.google.com with SMTP id o12so2543890pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxQYW/nnrzb7W5073+0iMTEQJ++9sTJN5W/GMW2FN1I=;
        b=AFFIqAWnDRv4folqfy/T/Ljb8pr8zkAnlgorZ67c5raMz+ejCcNcMmAahXPdj/uh2i
         mY8LRxN7UYP/Nsu4fTizjCYnYjDs2sM3gFqBGP3gFdUkxK+ZS94XtunXIKxoNq8I86Q9
         3misuD83KFRzr2MVGM1sU3D/VM5rJnj1zNNhlHde/GxONLu9PvKiesD319uX27Aeu5UK
         mpjEAjjjFbCbG8mlun/UW+MYkjqBuKyz8WaSk4Q9IqnYYk+FvRspJ9pSKuT0lvQ2H7pa
         X0HvLrd/Z7s3jTPxdKEHoLPbajwwgmIxlQxgXbGDEMiG92Hkm4eEtvZGaZb3IJwPS5X4
         O6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxQYW/nnrzb7W5073+0iMTEQJ++9sTJN5W/GMW2FN1I=;
        b=dJ5Dkxi1hhYAlAqyNKidnqg57ugjftyac85hIYZM0UAPmPlspLc3BIn0ubq36O5IP7
         BquUepxCK4nPJoKMuV+C1jUhkICJYHS+yqvVx5++TGm5NXy5d6NQuaG4EdqmlwW+h+X3
         Ib56qzq2r9olKbZYMb6X+9ejwGWUuyE95cIGvfcjypiC7xoKaz0lrCSJlVQdWff/2umI
         9LCNwMPFicaQIDHti8b3k5qP/JqYtEczY9dbGs3AesTX5rnN0n0RFE/0zTGUFW6JI+L6
         0LmmLtvWTjMumv7bjsxJJeqhUeYLjKuhBTqlFFeSLkYa6htH05CEy95enliEPtU9fdbI
         JDKg==
X-Gm-Message-State: ANhLgQ18vThkpk5DTi0y7iPDFn2wV2TzmH+qEiPN3362oypnwgfXdl5K
        xUUDcGPBuTc0OmYqnRAGNWiX3A==
X-Google-Smtp-Source: ADFU+vvGVhjWWJCwQHAO/ETHPGmnATcfj+jq0WdWxnlkrpMVACwroMGnDwpy3IX1TfsgQt4SofOoYQ==
X-Received: by 2002:a17:902:b115:: with SMTP id q21mr8292519plr.337.1585236407290;
        Thu, 26 Mar 2020 08:26:47 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id bo12sm1853269pjb.16.2020.03.26.08.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:26:46 -0700 (PDT)
Date:   Thu, 26 Mar 2020 08:26:36 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 04/11] hv_netvsc: Disable NAPI before closing the
 VMBus channel
Message-ID: <20200326082636.1d777921@hermes.lan>
In-Reply-To: <20200325225505.23998-5-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
        <20200325225505.23998-5-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 23:54:58 +0100
"Andrea Parri (Microsoft)" <parri.andrea@gmail.com> wrote:

> vmbus_chan_sched() might call the netvsc driver callback function that
> ends up scheduling NAPI work.  This "work" can access the channel ring
> buffer, so we must ensure that any such work is completed and that the
> ring buffer is no longer being accessed before freeing the ring buffer
> data structure in the channel closure path.  To this end, disable NAPI
> before calling vmbus_close() in netvsc_device_remove().
> 
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: <netdev@vger.kernel.org>

Do you have a test that reproduces this issue?

The netvsc device is somewhat unique in that it needs NAPI
enabled on the primary channel to interact with the host.
Therefore it can't call napi_disable in the normal dev->stop() place.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
