@extends('layouts.layout_admin')
@section('content')
<!-- Page Header -->
            <div class="page-header row no-gutters py-4">
              <div class="col-12 col-sm-4 text-center text-sm-left mb-0">
                <h3 class="page-title">Danh Sách Địa Danh</h3>
              </div>
            </div>
            <!-- End Page Header -->
            
            <!-- Default Dark Table -->
            <div class="row">
              <div class="col">
                <div class="card card-small overflow-hidden mb-4">
                  <div class="card-header bg-dark">
                    <h6 class="m-0 text-white">Inactive Users</h6>
                  </div>
                  <div class="card-body p-0 pb-3 bg-dark text-center">
                    <table class="table table-dark mb-0">
                      <thead class="thead-dark">
                        <tr>
                          <th scope="col" class="border-bottom-0">ID</th>
                          <th scope="col" class="border-bottom-0">Tên địa danh</th>
                          <th scope="col" class="border-bottom-0">Loại địa danh</th>
                          <th scope="col" class="border-bottom-0">Vùng</th>
                          <th scope="col" class="border-bottom-0">Miền</th>
                          <th scope="col" class="border-bottom-0">Lượt chia sẻ</th>
                        </tr>
                      </thead>
                      <tbody>
                        @foreach($lstDiaDanh as $diadanh)
                        <tr>
                          <td>{{$diadanh->id}}</td>
                          <td>{{$diadanh->ten_dia_danh}}</td>
                          <td>{{$diadanh->loaidiadanh}}</td>
                          <td>{{$diadanh->phanvung}}</td>
                          <td>{{$diadanh->mien}}</td>
                          <td>{{$diadanh->baiviets_count}}</td>
                        </tr>
                        @endforeach
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <!-- End Default Dark Table -->
          </div>
@endsection