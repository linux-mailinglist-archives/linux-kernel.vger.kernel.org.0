Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A035C17E15E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 14:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgCINjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 09:39:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45759 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgCINjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:39:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id c145so3390106qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OT1cMU23FRRt01mIbOygPM+s/6r4skVCYs9hBX0TQoo=;
        b=BstwzLDow1XFkd7aqQF5IO8xB5Yp89PhBU3vjef6r2kCSsoEi4Is19e01kq1kX/Vr+
         gW3t2GedDpCbkyHjJ8lvIeBInpdPO9rm5Kr/927nwZmWxeP6C2zqVOVaFoPPei67A4SD
         KBCLryZDqropt7RTB86He1KpQDlRbvqA1VJQQabLbUVj2BcaZUp4EgPxGPuBBzIx3Jwt
         gsEohrQlGgElf+/X94hmhpVQfhx9/GGget3KTAScUAa7ojt84+qQlrunbMkWx0SJL3Gr
         aeDMuS8EP6aJB7YSr1jnXc5En1SuMSU2rwgKVkEdPyzpsI/zkG6ODLwONTJKbDhps8Xt
         ESGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OT1cMU23FRRt01mIbOygPM+s/6r4skVCYs9hBX0TQoo=;
        b=GveUUmGD1NBh8ib6oGII2qkDQ+HBVx+oE+kVZu5cUQlRk2Z6LrUpwf04yXlsWPayGx
         g+5q9XUFPL/8v+HE9Ugc0SkzSK+VpMdoH3xkidFXvhGd4HBo7esdbRjwPVjFQHFVem4M
         seGrnDSvFEMvUPWKTsrgD6Zo0gRGKZLWb/UPFDv+dauy/ebXduF66DkZ9DM7wteb6r7F
         Tveio24LgNEgqF5RiujBHgXe9itmS1KmLvBNi1plMgL9froocNGBDsUNn/IjP09tXzFK
         YyGDhK2u7M3xWd84pAuXjwjA4umQqzrVpzvEU3Kr/5HFoMrOBJCoce9tIWONi0bKc/AY
         o2uA==
X-Gm-Message-State: ANhLgQ0y9XLHxsCScMfoMBVwPQmyK0Fp1kf5w69BZ762/Xt03xEnPrnb
        xQsbbaHkiFqk340r/k8sO/I=
X-Google-Smtp-Source: ADFU+vsGDDbSHVJ//JjwX2o5Kq57yJOubTjAkERo82js25kIK1p3b2TZB6dBxIx2f9opN2ucIOI+jA==
X-Received: by 2002:a37:3d7:: with SMTP id 206mr14274103qkd.179.1583761170741;
        Mon, 09 Mar 2020 06:39:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h6sm22363558qtr.33.2020.03.09.06.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 06:39:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0F6840009; Mon,  9 Mar 2020 10:39:27 -0300 (-03)
Date:   Mon, 9 Mar 2020 10:39:27 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCHv3 0/5] perf expr: Add flex scanner
Message-ID: <20200309133927.GC477@kernel.org>
References: <20200228093616.67125-1-jolsa@kernel.org>
 <20200229122704.GA1319864@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229122704.GA1319864@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Feb 29, 2020 at 04:27:04AM -0800, Andi Kleen escreveu:
> On Fri, Feb 28, 2020 at 10:36:11AM +0100, Jiri Olsa wrote:
> > hi,
> > while preparing changes for user defined metric expressions
> > I also moved the expression manual parser to flex.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied,

- Arnaldo
