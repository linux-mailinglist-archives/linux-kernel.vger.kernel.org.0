Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1FF7A6CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfICPSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 11:18:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42572 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICPSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:18:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id y91so6972703ede.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=M/MgUkf0bO2y1PXvF3i03lzNOLBm92Qd4oy/UMB5kQA=;
        b=EvTOIWYVWgrd7AbgV5YsYOXbSXD4jwxgmejN3UTHIJhGn03ikVBqZeHHeW7u9lqI34
         /MjiQvOoCtQU/+TI25Ks7pHxMntaHG7efrJjU8krFLkWkYKQEcCc2e+qk5E4xrAi3uEH
         2tcPUTv5f5FovKVuc7SvXkwXE/nB1wU1AczuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=M/MgUkf0bO2y1PXvF3i03lzNOLBm92Qd4oy/UMB5kQA=;
        b=jEb2nSeDGFdPj2Ah6hxC84f70la1ynXkY0nhjNinOu1h8FyI3L1y4MI/TPse/YBWEd
         GxgaUIEN0EsINWE7P6jX0uFPy1PEScfd8KbNSRQR8uCxUpGvWGUstv7rg6r9rz35OLFr
         2devQPf6UF7vRdWBG6ZNVRknh1e+fjra+JUbiXbgsot/xsVsy73PjG/e6gYS606RXgvP
         +gNUvF4H9OgJSK7JMlCVuUE5HVcYVyCOC14kpRkAjyoRpsmv56tFbhJTZ0UiWc7R4BD/
         RtevVRpSmpSedH4Zqn+esHDfDJY7gApyYqFcy11kGpHUR2msGA3LdaXjCyLinjSk+Rie
         +Rjg==
X-Gm-Message-State: APjAAAWnwoWcJs82WEXyNvZXcV2E9+ZG9bRDVlT5hxQsSEH4kbqTz94b
        3SudlnwqR1SGDqF9/zs69rxQ6UgUETs=
X-Google-Smtp-Source: APXvYqwZYMPuR026foAliFROtcKkxtxin7G2+x5wezCSiXYr6+gpxIU+tlEuN6Cd2MU96aGSP0aElw==
X-Received: by 2002:a05:6402:894:: with SMTP id e20mr36411232edy.69.1567523933187;
        Tue, 03 Sep 2019 08:18:53 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id m22sm3381056edp.50.2019.09.03.08.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 08:18:52 -0700 (PDT)
Date:   Tue, 3 Sep 2019 17:18:50 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Have TTM support SEV encryption with coherent
 memory
Message-ID: <20190903151850.GB2112@phenom.ffwll.local>
Mail-Followup-To: Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= <thomas_os@shipmail.org>,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org
References: <20190903131504.18935-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903131504.18935-1-thomas_os@shipmail.org>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:15:00PM +0200, Thomas Hellström (VMware) wrote:
> With SEV memory encryption and in some cases also with SME memory
> encryption, coherent memory is unencrypted. In those cases, TTM doesn't
> set up the correct page protection. Fix this by having the TTM
> coherent page allocator call into the platform code to determine whether
> coherent memory is encrypted or not, and modify the page protection if
> it is not.
> 
> v2:
> - Use force_dma_unencrypted() rather than sev_active() to catch also the
>   special SME encryption cases.

We should probably cc Christoph Hellwig on this ... better to hear his
screams before merging than afterwards. As much as I don't support
screaming maintainers, that seems the least bad option here.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
