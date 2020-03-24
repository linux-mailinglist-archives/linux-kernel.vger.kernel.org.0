Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3543191687
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgCXQes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:34:48 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:33096 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgCXQes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:34:48 -0400
Received: by mail-qt1-f173.google.com with SMTP id c14so3014939qtp.0;
        Tue, 24 Mar 2020 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zjM1Dr6U8Ncu7+tZqcA7GfhBYFviQteXVKvoP4H7dDs=;
        b=jdMdh3oAmkRiPXiqK62dwfOOu1YH6DF8ht6Opq+CDxsF1nNWAlsA8RHFBLSHFVwjNx
         zAB5GNyfzmk7Luq8tCcuc5qmI8UUOaPcpe26nM2FDqfuuCo3gTxmKfwOLLotjvYsFlPZ
         lb1kvXkC9HY/mpdg4Wbt2HuLplInlcsqt2TM2sr2DJ274ih38irgcONhHcrKegeJMFLe
         WrPRMHLDLf63TRqo7/H/FoZZpwnGvTMOh3ed2L0ZOynuiZlFD8Ds/7SzDPkO3rf6mUVa
         hIOK89/36hE/Qe7OEsLEXVoe6cVQksrhPzuJ8gZoGM8tvKGzeUM/45neYVO0wuaJ+sNx
         IlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zjM1Dr6U8Ncu7+tZqcA7GfhBYFviQteXVKvoP4H7dDs=;
        b=EgMOjCxVhJaa/qNUUZlYCdIJ4Nqrj9haecFXE91PvaP7tnkw5Sw2tkRaGP6KcCIyDM
         D345p5n6xnnd5XulZ2VWpI4mlaqbeO5PzGRdRerT/BopPofqAUOJpIRrrq/pRWcK6K5e
         TTBbtD3qSaAmo8KxdWmTNB96b/B+MQB4ujQTqpMeqRH6IMFo6hphacqYNeyycZ5rsb5L
         yzelNbPEvHVzat7/39d26lLvxEg8vPf08fC9NW/foUniGvG0uWqb4+WHXZeVUseIKg52
         NhE2iKwSaaSAwKWdJXb78gfDrtI9j1vSkWc6710QF2pgO+BsS5+9WB9kLfX3MDvNv8Lb
         DwJQ==
X-Gm-Message-State: ANhLgQ01PAQTX5N94gN8MVKw1gJYb5/WYVD9q9rPVIuDhUwpHYyWFtjr
        nVGozyQn+fnHpce88DKkHkE=
X-Google-Smtp-Source: ADFU+vsfq03/5/bRB3KJecLmtp47T8cY+kZaJHdSXrihC6zKqKlt9O9Zd/m54I8y3g/1Orq36mH71g==
X-Received: by 2002:ac8:6d31:: with SMTP id r17mr15870397qtu.68.1585067686776;
        Tue, 24 Mar 2020 09:34:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:7bc9])
        by smtp.gmail.com with ESMTPSA id y132sm3730719qka.19.2020.03.24.09.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 09:34:45 -0700 (PDT)
Date:   Tue, 24 Mar 2020 12:34:44 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHSET 00/10] perf: Improve cgroup profiling (v5)
Message-ID: <20200324163444.GA162390@mtj.duckdns.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
 <CAM9d7chneHzibiQFopmN1rED=mf-nBpy58kauXWSOSYy2zCtzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chneHzibiQFopmN1rED=mf-nBpy58kauXWSOSYy2zCtzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 08:58:04AM +0900, Namhyung Kim wrote:
> Hello Peter, Tejun and folks.
> 
> Do you have any other comments on the kernel side?
> If not, can I get your Ack?

Everything looks good from cgroup side. I think I acked all cgroup parts already
but if not please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
