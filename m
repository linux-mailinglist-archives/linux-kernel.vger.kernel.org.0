Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1938D116CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 13:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfLIMBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 07:01:46 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:34890 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575892904; x=1607428904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XvRR7gQY2FQJatuw/ophADlxtuoMusOU93AHjmf9lGY=;
  b=oybjfxfCv7PSTdkGnD1iiMGgAMMifi+32iWjBWqXnZ1fU7fwTNwXnQnn
   g2ja/QcgQnHiowCHKnJxicWJKKmpWanRcr+ry9KCTIDKAtFZ0Hstx/igY
   ImC3/7u0vRtrJ8hkLMI8qlmwtZDX2GKB+8RPwU/0zR0u5x+tjBvR0l1ZI
   s=;
IronPort-SDR: PmvwQo4VnzBLjfnNJGwXkqt+n4PosgQshR9n6DuHBw9xplP0Z4ts5Y/FFs9acKdrfrJ6NRwsV0
 BEcmp/w7sxmQ==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="7663811"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 09 Dec 2019 12:01:42 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id E58CB240AF1;
        Mon,  9 Dec 2019 12:01:39 +0000 (UTC)
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 12:01:39 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC003.ant.amazon.com (10.43.164.24) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 12:01:38 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Mon, 9 Dec 2019 12:01:38 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: RE: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Thread-Topic: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
Thread-Index: AQHVq3SCoU35oX1INEGjFwMD1PQM5aexs7UAgAAEsBA=
Date:   Mon, 9 Dec 2019 12:01:38 +0000
Message-ID: <19b5c2fa36b842e58bbdddd602c4e672@EX13D32EUC003.ant.amazon.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
In-Reply-To: <20191209113926.GS980@Air-de-Roger>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.211]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Roger Pau Monn=E9 <roger.pau@citrix.com>
> Sent: 09 December 2019 11:39
> To: Durrant, Paul <pdurrant@amazon.com>
> Cc: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org; Juergen
> Gross <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>;
> Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced t=
o
> closed
>=20
> On Thu, Dec 05, 2019 at 02:01:21PM +0000, Paul Durrant wrote:
> > Only force state to closed in the case when the toolstack may need to
> > clean up. This can be detected by checking whether the state in xenstor=
e
> > has been set to closing prior to device removal.
>=20
> I'm not sure I see the point of this, I would expect that a failure to
> probe or the removal of the device would leave the xenbus state as
> closed, which is consistent with the actual driver state.
>=20
> Can you explain what's the benefit of leaving a device without a
> driver in such unknown state?
>=20

If probe fails then I think it should leave the state alone. If the state i=
s moved to closed then basically you just killed that connection to the gue=
st (as the frontend will normally close down when it sees this change) so, =
if the probe failure was due to a bug in blkback or, e.g., a transient reso=
urce issue then it's game over as far as that guest goes.
The ultimate goal here is PV backend re-load that is completely transparent=
 to the guest. Modifying anything in xenstore compromises that so we need t=
o be careful.

  Paul
